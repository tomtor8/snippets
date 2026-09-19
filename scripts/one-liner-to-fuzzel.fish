#!/usr/bin/env fish

set -l file "$HOME/.local/share/snippets/one_liners/one-liners.txt"
set -l line (cat "$file" | fuzzel --dmenu -w 60 --prompt="One-liner ❯ ")

if test -n "$line"
    set -l code (string match -r ':\s*(.*)' "$line")[2]
    wl-copy "$code"
    notify-send "Copied One-liner" "$code"
end
