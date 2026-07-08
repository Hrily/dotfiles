## Output style

Always follow the rules in the `i-have-adhd` skill: action-first, numbered steps, no preamble, no closers, state restated each turn.

Every deliverable — docs, RCAs, comments, PR descriptions, replies — must be **concise yet comprehensive, no fluff**.

## Engineering defaults

- Test the correct unit/module/system under change — the actual repository/component, and the right environment (prod-shadow or staging) when the environment is the thing you're validating. A green test against the wrong layer proves nothing. Local integration testing is not mandatory — CI runs the integration tests; don't block on running them locally.
- Keep code minimal: only comments that explain non-obvious intent, and the simplest idiomatic construct. Don't over-build or over-comment.
