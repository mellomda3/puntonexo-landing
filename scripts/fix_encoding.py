#!/usr/bin/env python3
"""Repara mojibake (UTF-8 mal interpretado) en HTML estáticos de la landing."""
from __future__ import annotations

import sys
from pathlib import Path

try:
    import ftfy
except ImportError:
    print("Instalá ftfy: pip install ftfy", file=sys.stderr)
    sys.exit(1)

MANUAL = {
    "âš¡": "⚡",
    "â–¾": "▾",
    "â€”": "—",
    "â€¢": "•",
    "âœ“": "✓",
    "â†’": "→",
}


def fix_text(text: str) -> str:
    fixed = ftfy.fix_text(text)
    for bad, good in MANUAL.items():
        fixed = fixed.replace(bad, good)
    return fixed


def main() -> int:
    root = Path(__file__).resolve().parent.parent
    changed = 0
    for path in sorted(root.glob("*.html")):
        raw = path.read_text(encoding="utf-8-sig")
        fixed = fix_text(raw)
        if fixed != raw:
            path.write_text(fixed, encoding="utf-8", newline="\n")
            print(f"Fixed {path.name}")
            changed += 1
        else:
            print(f"OK {path.name}")
    return 0 if changed >= 0 else 1


if __name__ == "__main__":
    raise SystemExit(main())
