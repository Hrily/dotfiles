# Leaf-Ticket Contract

The phase↔leaf interface: what the `implementation` phase agent writes into each leaf
ticket so an `implement-plan` agent can run one atomic task from a cold start without
re-reading the ERD. The exit contract is agent↔orchestrator; this is the same idea one
level down — phase↔leaf.

**How it's used.** Implementation's Plan step produces a FACTS-checked atomic task list.
For each task the phase creates a leaf ticket — a child of the Implementation subtask — in
`Backlog`, fills the description per this contract, then promotes the children
`Backlog → Todo` one at a time. The `cortana:<leaf-label>` label routes each to
`implement-plan`.

## What goes in a leaf ticket

A small, fixed structure in the ticket description. Anything the phase already knows that
the leaf would otherwise have to rediscover belongs here; nothing else does.

- **Task** — one atomic unit of work, one PR's worth. (FACTS: atomic, scoped.)
- **Exit criteria** — the testable conditions for `pass`: the behavior to land plus green
  module/unit tests. This is what the leaf checks itself against before emitting its
  verdict. (FACTS: testable.)
- **Contracts** — the interfaces / data-model / API-event shapes from Planning this task
  must implement against. This is the boundary the leaf has to honor; if it can't, the
  leaf stalls rather than routing (see `phase-exit-contract.md` → leaf verdict shape).
- **Pointers** — the ERD/OnePager link plus the relevant code locations the phase's
  Research step already found, so the leaf doesn't re-research from zero.
- **Sequence** — children are promoted sequentially, so a leaf may assume all prior
  siblings in this iteration are merged. Note any specific dependency.

## Wiring (set by the phase when it creates the ticket)

- **Parent** — the Implementation subtask. (Also satisfies Cortana's target-ticket
  resolution for PR linking.)
- **Label** — `cortana:<leaf-label>` routes the ticket to `implement-plan`. *(Leaf label
  name is still the open micro-decision: `implement-plan` vs `impl-task` / `coder`.)*
- **Status** — created in `Backlog`; the phase promotes to `Todo` to launch it.

## What the leaf returns

The leaf profile of the phase exit contract: `pass` + one merged `pr` artifact, and no
back-edge. A leaf that can't pass stalls to `Blocked` for the phase agent. See
`phase-exit-contract.md` → Verdict profiles.

## Template

```jsonc
// leaf ticket description
{
  "task": "one atomic, scoped unit of work",
  "exit_criteria": ["testable condition(s) for the change", "module/unit tests green"],
  "contracts": ["interface / data-model / event shape this task implements against"],
  "pointers": {
    "erd": "url",
    "code": ["path or location from the phase's Research step"]
  },
  "depends_on": ["prior leaf ticket id, if any"]   // optional; siblings merge in order
}
```
