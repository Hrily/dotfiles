#!/usr/bin/env python3
"""Stop hook: refuse a reply that breaks the deterministic ADHD prose rules.

Only three checks, all mechanical: a forbidden opener, a forbidden closer, and a prose-word
ceiling that lifts when the user actually asked for depth. Anything subtler is left to the
per-turn reminder — a gate that guesses would block good answers.

Always exits 0 and writes at most one JSON object: a broken gate must never strand a turn.
"""

import json
import pathlib
import re
import sys

WORD_CAP = 400  # prose words outside code fences; a normal reply is far under this
OPENER = re.compile(
    r"^(great question|let me\b|i'll\b|i will\b|sure!|looking at your|to answer your question|"
    r"certainly[,!.]|of course[,!.]|i've now|i have now)",
    re.I,
)
CLOSER = re.compile(
    r"(let me know if|hope this helps|happy to (help|clarify|assist)|feel free to ask|"
    r"anything else\?|is there anything else)",
    re.I,
)
DEPTH_ASKED = re.compile(
    r"\b(explain|walk me through|why does|why is|how does|plan|design|review|audit|document|"
    r"rca|report|compare|deep ?dive|teach|understand)\b",
    re.I,
)
FENCE = re.compile(r"```.*?```", re.S)


def prose_words(text):
    """Word count with fenced code removed, so a big diff never trips the ceiling."""
    return len(FENCE.sub(" ", text).split())


def violations(reply, prompt):
    out = []
    lines = [ln.strip() for ln in reply.strip().splitlines() if ln.strip()]
    if not lines:
        return out
    if OPENER.match(lines[0]):
        out.append(f'Forbidden opener: "{lines[0][:60]}". Delete it; open with the answer.')
    tail = " ".join(lines[-2:])
    if CLOSER.search(tail):
        out.append(f'Forbidden closer: "{tail[-70:]}". Delete it; end when the answer is done.')
    count = prose_words(reply)
    if count > WORD_CAP and not DEPTH_ASKED.search(prompt):
        out.append(
            f"{count} prose words for a request that did not ask for depth (cap {WORD_CAP}). "
            "Cut to the answer plus the one next action; offer the rest as a follow-up question."
        )
    return out


def last_turn(path):
    """The last assistant text and the last real user prompt from the transcript."""
    reply, prompt = "", ""
    with open(path, encoding="utf-8") as fh:
        for line in fh:
            try:
                row = json.loads(line)
            except ValueError:
                continue
            msg = row.get("message") or {}
            content = msg.get("content")
            if row.get("type") == "assistant":
                if isinstance(content, list):
                    text = "\n".join(
                        b.get("text", "") for b in content if b.get("type") == "text"
                    ).strip()
                    if text:
                        reply = text
            elif row.get("type") == "user":
                # why: a string content is a typed prompt; a list is a tool result, not the user
                if isinstance(content, str) and content.strip():
                    prompt = content
    return reply, prompt


def main():
    data = json.loads(sys.stdin.read() or "{}")
    if (pathlib.Path(__file__).resolve().parent.parent / "active-style").read_text().strip() == "ste":
        return  # why: STE's own meter scores the reply instead
    if data.get("stop_hook_active"):  # why: one block per turn, never a loop
        return
    reply, prompt = last_turn(data["transcript_path"])
    found = violations(reply, prompt)
    if found:
        sys.stdout.write(
            json.dumps(
                {
                    "decision": "block",
                    "reason": "ADHD prose rules — rewrite the reply, then finish:\n- "
                    + "\n- ".join(found),
                }
            )
        )


def selftest():
    assert violations("Let me check that for you.", "fix it")
    assert violations("Done. Hope this helps!", "fix it")
    assert not violations("Done. Cache now hits.", "fix it")
    assert violations("word " * 500, "make it work")
    assert not violations("word " * 500, "explain how this works")
    assert prose_words("a b ```\nlots of code here\n``` c") == 3
    print("ok")


if __name__ == "__main__":
    if "--selftest" in sys.argv:
        selftest()
    else:
        try:
            main()
        except Exception:  # noqa: BLE001 — fail open, never strand a turn
            pass
