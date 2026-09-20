#!/usr/bin/env fish

set -l snippet_file "$HOME/.local/share/snippets/one_liners/one-liners.txt"
if not test -f "$snippet_file"
    notify-send "Snippet Picker" "File $snippet_file not found."
    exit 1
end

# Select snippet via Fuzzel
set -l selected_line (fuzzel --dmenu -w 60 --placeholder='Alt+1 Copy to Clipboard' --prompt="One-liner ❯ " < "$snippet_file")
set -l exit_status $status

if contains $exit_status 0 10
    if test -n "$selected_line"
        # extract text after :: and trim whitespace
        set -l text (string split -f2 '::' "$selected_line" | string trim)

        # copy to clipboard in both cases
        wl-copy -- "$text"

        switch $exit_status
            case 0
                # let window focus return from fuzzel
                sleep 0.15

                # Paste via ydotool Ctrl+V (29=KEY_LEFTCTRL, 47=KEY_V)
                if not ydotool key 29:1 47:1 47:0 29:0 >/dev/null 2>&1
                    notify-send "ydotool failed" "One-liner copied to clipboard:\n$text"
                end

            case 10
                # Alt+1 copy to clipboard only
                notify-send "Copied One-liner" "$text"
        end
    end
end
