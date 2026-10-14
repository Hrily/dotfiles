## Output style

Every deliverable — docs, RCAs, comments, PR descriptions, replies — must be **concise yet comprehensive, no fluff**.

## Engineering defaults

- Test the correct unit/module/system under change — the actual repository/component, and the right environment (prod-shadow or staging) when the environment is the thing you're validating. A green test against the wrong layer proves nothing. Local integration testing is not mandatory — CI runs the integration tests; don't block on running them locally.
- Keep code minimal: only comments that explain non-obvious intent, and the simplest idiomatic construct. Don't over-build or over-comment.

## PR review flow

1. After implementation, do an adversarial self-review of the whole diff and fix what it finds.
2. Raise the PR.
3. Request bot review by adding a GitHub label (not by `@codex review` comments):

   | Label | What it does |
   |---|---|
   | `os-review` | Normal code review |
   | `os-adversarial` | Review that actively tries to break the change |

   If you add `os-review` before the PR leaves draft, it also re-reviews after each later push. Pushes are debounced, so you get one review after a quiet period, not one per push.
4. When a bot finds one instance of a class of issue, sweep the whole diff for the class before you push the fix. If a bot replies that it is not connected or out of credits, stop requesting it on that PR and rely on your own review. If a bot has shown "reviewing" for over two hours with nothing posted, say so on the ticket and apply the merge rule without it.
