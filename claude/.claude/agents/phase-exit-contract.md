# Phase Exit Contract

The typed verdict every phase subagent — and every Implementation task-child agent —
returns to the orchestrator. The orchestrator never re-derives the routing decision; it
dispatches on this verdict against the routing table. The agent that ran the work makes
the judgment call (it has the context); the orchestrator only records and routes.

## Schema

```jsonc
{
  "result": "pass" | "back_edge",   // required

  // present iff result == "back_edge"; must be one of the named edges below
  "edge": "design-no-longer-holds"
        | "e2e-failure"
        | "uat-miss"
        | "regression-or-slo-cost-breach",

  // required for back_edge; short, written verbatim into the target subtask comment
  "reason": "string",

  // artifacts produced this phase; written as links on the phase subtask.
  // a `pass` MUST carry its profile's required artifact (see Verdict profiles).
  "artifacts": [
    { "kind": "erd" | "onepager" | "pr" | "release_tag" | "monitoring_result",
      "url": "string" }
  ],

  // optional, audit only
  "gates": { "far": true, "facts": true }   // which intra-phase gates passed
}
```

The orchestrator infers the **emitter** from context (which subtask it invoked / which
child session it read), so the verdict carries no `from` field. The **target** of a
back-edge is likewise not carried — the orchestrator maps `edge → target` via the routing
table. The payload states *what happened*; the table decides *where it goes*.

## Human gates are not verdicts

A phase subtask in `Blocked` carrying the `awaiting:human` label and a
`{"request":"human-approval","gate":"questions"|"design"|"plan","summary":"..."}` comment is
**paused on an intra-phase human gate**, not emitting a back_edge. The orchestrator must not
route it. A human reviews the linked artifact, comments (approval or change requests), and
flips the subtask back to `Todo`; Cortana resumes the phase agent, which reads the comments
and proceeds or revises. Gates: `questions` and `design` (Planning), `plan` (Implementation).

## Named edges (must match `sdlc-state-diagram.mermaid`)

| `edge` | Emitted by | Routes to | Meaning |
|---|---|---|---|
| `design-no-longer-holds` | Implementation (phase) | Planning | contract/design must change |
| `e2e-failure` | Testing+Deployment | Implementation | e2e or integration failed |
| `uat-miss` | Testing+Deployment | Planning | wrong thing built — requirement/design miss, not a code bug |
| `regression-or-slo-cost-breach` | Monitoring | Implementation | health/SLO/cost check failed |

`pass` carries no edge. A phase only emits `pass` once its exit criteria (per
`phases.md`) are met — FAR on research, FACTS on plans, plus the phase-specific gates.

## Verdict profiles

One schema, two profiles. Each profile pins the **legal edges** an emitter may use and the
**artifact a `pass` must carry**. An emitter producing a verdict outside its profile is a
contract violation, not a routing edge — the orchestrator treats it as a failed phase.

| Emitter | Profile | Legal on `pass` (required artifact) | Legal `back_edge` edges |
|---|---|---|---|
| `planning` | phase | exactly one of `erd` \| `onepager` | *(none — pass only)* |
| `implementation` | phase | *(no new artifact; evidence is the children's merged PRs)* | `design-no-longer-holds` |
| `implement-plan` | leaf | exactly one `pr` (merged) | *(none — pass only)* |
| `test-deploy` | phase | exactly one `release_tag` | `e2e-failure` \| `uat-miss` |
| `monitoring` | phase | exactly one `monitoring_result` | `regression-or-slo-cost-breach` |

**Leaf verdict shape.** A task child under Implementation emits exactly one verdict:
`pass` + a merged `pr` artifact → the orchestrator promotes the next child. A leaf has no
back-edge. It does atomic work and either succeeds or stalls; it makes no routing calls.

A leaf that cannot pass — including one that discovers the design no longer holds — does
**not** route. It moves to `Blocked`, which via `[subtask_watch]` wakes the Implementation
phase agent; that agent owns the `design-no-longer-holds` decision and emits it at the
phase level (see `agents/orchestrator.md`). Keeping the leaf the one agent that never routes
is deliberate.

A leaf `pass` presupposes green module/unit tests; that gate is enforced by CI on the merged
PR, so it is a precondition of emitting `pass`, not a separate field.

## Examples

Planning passes:
```json
{ "result": "pass",
  "artifacts": [{ "kind": "erd", "url": "https://linear.app/.../erd" }],
  "gates": { "far": true } }
```

Testing+Deployment, UAT reveals the wrong build:
```json
{ "result": "back_edge", "edge": "uat-miss",
  "reason": "Export flow built per ERD, but UAT shows users need per-row export, not bulk.",
  "artifacts": [] }
```

Implementation phase hits a design break (a stalled leaf surfaced it; the phase agent makes the call):
```json
{ "result": "back_edge", "edge": "design-no-longer-holds",
  "reason": "Planned event schema can't carry tenant id; contract change needed.",
  "artifacts": [] }
```

Implementation task child passes:
```json
{ "result": "pass",
  "artifacts": [{ "kind": "pr", "url": "https://github.com/.../pull/214" }],
  "gates": { "far": true, "facts": true } }
```
