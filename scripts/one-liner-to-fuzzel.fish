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
        # let window focus return from fuzzel
        sleep 0.15
        switch $exit_status
            case 0
                # attempt to type using wtype
                if not wtype -- "$text" >/dev/null 2>&1
                    # fallback if wtype fails
                    wl-copy "$text"
                    notify-send "wtype fail" "\nOne-liner copied to clipboard" "$text"
                end
            case 10
                # Alt+1 copy to clipboard
                wl-copy "$text"
                notify-send "Copied One-liner" "$text"
        end
    end
end
