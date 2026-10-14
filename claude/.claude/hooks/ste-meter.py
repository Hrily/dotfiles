#!/usr/bin/env python3
"""Stop: score the reply that just finished, write one line to ste-meter.log for the next prompt.

Five mechanical checks only, all drawn from ste-card.md. Anything a script cannot count
(answer-first, length matching the question) stays the card's job, not the meter's.
Never blocks, prints nothing, always exits 0.
"""

import importlib.util
import json
import pathlib
import re
import sys

HERE = pathlib.Path(__file__).resolve().parent
MAX_WORDS = 25  # the card's explanation ceiling
FENCE = re.compile(r"```.*?```|`[^`]*`", re.S)
FORMAL = re.compile(r"\b(leverage[sd]?|utilis[ei]|utiliz[ei]|robust|seamless|comprehensive)\b", re.I)
HEDGE = re.compile(r"\b(perhaps|possibly|might|could possibly|it seems|arguably|somewhat|fairly)\b", re.I)
DASH = re.compile(r"[—–]| -- ")


def lint(text):
    prose = FENCE.sub(" ", text)
    sentences = [s for s in re.split(r"(?<=[.!?])\s+", prose) if s.strip()]
    return {
        "long_sentence": sum(1 for s in sentences if len(s.split()) > MAX_WORDS),
        "semicolon": prose.count(";"),
        "formal_word": len(FORMAL.findall(prose)),
        "hedge": len(HEDGE.findall(prose)),
        "dash": len(DASH.findall(prose)),
    }


def _last_turn(path):
    """Borrow the transcript reader already living next door rather than copy it."""
    spec = importlib.util.spec_from_file_location("adhd_gate", HERE / "adhd-gate.py")
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod.last_turn(path)[0]


def main():
    if (HERE.parent / "active-style").read_text(encoding="utf-8").strip() != "ste":
        return
    data = json.loads(sys.stdin.read() or "{}")
    text = data.get("last_assistant_message") or _last_turn(data["transcript_path"])
    if not text.strip():
        return
    with (HERE / "ste-meter.log").open("a", encoding="utf-8") as fh:
        fh.write(
            json.dumps({"session_id": data.get("session_id"), "violations": lint(text)}) + "\n"
        )


def selftest():
    assert lint("Done.")["long_sentence"] == 0
    assert lint("word " * 40 + ".")["long_sentence"] == 1
    assert lint("We leverage a robust cache; it is seamless.") == {
        "long_sentence": 0, "semicolon": 1, "formal_word": 3, "hedge": 0, "dash": 0
    }
    assert lint("```\n" + "word " * 40 + ";\n```")["long_sentence"] == 0  # fenced code is exempt
    assert lint("It might work — perhaps.")["hedge"] == 2
    assert lint("It might work — perhaps.")["dash"] == 1
    print("ok")


if __name__ == "__main__":
    if "--selftest" in sys.argv:
        selftest()
    else:
        try:
            main()
        except Exception:  # noqa: BLE001 - fail open, never strand a turn
            pass
