#!/usr/bin/python3
"""Render component themes from the versioned Catppuccin Mocha palette."""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PALETTE = ROOT / "theme/catppuccin-mocha.json"
OUTPUTS = {
    ROOT / "theme/templates/hypr-theme.lua.in": ROOT / "hypr/.config/hypr/modules/theme.lua",
    ROOT / "theme/templates/hyprlock.conf.in": ROOT / "hypr/.config/hypr/hyprlock.conf",
    ROOT / "theme/templates/waybar-colors.css.in": ROOT / "waybar/.config/waybar/colors.css",
    ROOT / "theme/templates/fuzzel.ini.in": ROOT / "fuzzel/.config/fuzzel/fuzzel.ini",
    ROOT / "theme/templates/mako.conf.in": ROOT / "mako/.config/mako/config",
    ROOT / "theme/templates/kitty.conf.in": ROOT / "kitty/.config/kitty/catppuccin-mocha.conf",
}
TOKEN = re.compile(r"\{\{([a-z0-9]+)\}\}")


def render(template: Path, colors: dict[str, str]) -> str:
    source = template.read_text(encoding="utf-8")

    def replace(match: re.Match[str]) -> str:
        name = match.group(1)
        try:
            return colors[name]
        except KeyError as error:
            raise SystemExit(f"unknown palette color {name!r} in {template}") from error

    result = TOKEN.sub(replace, source)
    remaining = TOKEN.findall(result)
    if remaining:
        raise SystemExit(f"unexpanded tokens in {template}: {remaining}")
    return result


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--check",
        action="store_true",
        help="report stale generated files without modifying them",
    )
    args = parser.parse_args()

    colors = json.loads(PALETTE.read_text(encoding="utf-8"))["colors"]
    stale: list[Path] = []

    for template, output in OUTPUTS.items():
        expected = render(template, colors)
        if args.check:
            if not output.exists() or output.read_text(encoding="utf-8") != expected:
                stale.append(output.relative_to(ROOT))
            continue
        output.parent.mkdir(parents=True, exist_ok=True)
        output.write_text(expected, encoding="utf-8")

    if stale:
        for output in stale:
            print(f"stale generated theme: {output}", file=sys.stderr)
        return 1
    if args.check:
        print("Generated themes are current")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
