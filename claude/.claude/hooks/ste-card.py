#!/usr/bin/env python3
"""UserPromptSubmit: print the reply standard beside every prompt. The model reads it; you never see it.

Routing (deterministic):
  a question or an ask for an explanation  -> the whole card
  a build instruction                      -> the Shape half only
  a one-liner with no question             -> one line back

Loop: if the meter scored the previous reply with violations, the card opens by naming them.
Adapted from Kem's Reply Standard (Glitch Cat Club, "STE, tested"). Always exits 0.
"""

import datetime
import json
import pathlib
import re
import sys

HERE = pathlib.Path(__file__).resolve().parent
QUESTION = re.compile(
    r"\?|^(why|what|how|should|is|are|can|could|which|do|does|explain|tell me|help me understand)\b",
    re.I,
)


def main():
    if (HERE.parent / "active-style").read_text(encoding="utf-8").strip() != "ste":
        return  # why: the ADHD reminder owns the turn instead

    card = (HERE / "ste-card.md").read_text(encoding="utf-8")
    log = HERE / "ste-meter.log"
    prompt = (
        json.loads(sys.stdin.buffer.read().decode("utf-8", "replace")).get("prompt") or ""
    ).strip()
    sys.stdout.reconfigure(encoding="utf-8")

    prefix = ""
    if log.exists():
        lines = log.read_text(encoding="utf-8").strip().splitlines()
        if lines:
            broke = [
                f"{k.replace('_', ' ')} x{v}"
                for k, v in json.loads(lines[-1]).get("violations", {}).items()
                if v
            ]
            if broke:
                prefix = (
                    "Your previous reply broke the standard: " + ", ".join(broke) + ". Not this time."
                )
                print(prefix, end="\n\n")

    words = len(prompt.split())
    if QUESTION.search(prompt) or words > 12:
        mode = "full card"
        print(card)
    elif words <= 6:
        mode = "one line"
        print("REPLY STANDARD: one line back, plain words, British spelling, no preamble.")
    else:
        mode = "shape half"
        print("REPLY STANDARD (read before you answer)\n\nShape:" + card.split("Shape:", 1)[1])

    # one line per firing, so you can see what the model was actually handed
    with (HERE / "ste-card.log").open("a", encoding="utf-8") as fh:
        fh.write(
            json.dumps(
                {
                    "at": datetime.datetime.now().isoformat(timespec="seconds"),
                    "mode": mode,
                    "prefix": prefix,
                    "prompt": prompt[:80],
                }
            )
            + "\n"
        )


if __name__ == "__main__":
    try:
        main()
    except Exception:  # noqa: BLE001 - fail open, never strand a turn
        pass
