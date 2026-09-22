#!/usr/bin/env fish

set -l snippet_dir "$HOME/.local/share/snippets/code_snips"

if not test -d "$snippet_dir"
    echo "Snippet directory $snippet_dir does not exist."
    exit 1
end

# --base-directory forces fd to run inside $snippet_dir and output relative paths
set -l relative_file (fd --type f --base-directory "$snippet_dir" | fuzzel --dmenu -w 60 --placeholder='Alt+1 Copy | Alt+2 Paste' --prompt="Snippet ❯ ")
set -l exit_status $status

if contains $exit_status 0 10 11; and test -n "$relative_file"
    set -l full_path "$snippet_dir/$relative_file"

    switch $exit_status
        case 0
            foot --app-id foot-snip -e nvim "$full_path"

        case 10 11
            wl-copy <"$full_path"

            if test $exit_status -eq 10
                notify-send "Snippet Copied" "$relative_file" -i edit-copy
            else
                # Inject Ctrl+V using ydotool (29=KEY_LEFTCTRL, 47=KEY_V)
                # :1 key down, :0 key up
                sleep 0.15
                if not ydotool key 29:1 47:1 47:0 29:0 >/dev/null 2>&1
                    notify-send "ydotool failed" "Snippet copied to clipboard:\n$relative_file" -i edit-copy
                    exit 1
                end
            end
    end
end
