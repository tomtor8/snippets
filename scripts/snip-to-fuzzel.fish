#!/usr/bin/env fish

set -l snippet_dir "$HOME/.local/share/snippets/code_snips"

if not test -d "$snippet_dir"
    echo "Snippet directory $snippet_dir does not exist."
    return 1
end

# --base-directory forces fd to run inside $snippet_dir and output relative paths
# outputs eg, lua/some_snippet.lua
set -l relative_file (fd --type f --base-directory "$snippet_dir" | fuzzel --dmenu -w 60 --placeholder='Alt+1 Copy to Clipboard' --prompt="Snippet ❯ ")
set -l exit_status $status

if contains $exit_status 0 10
    if test -n "$relative_file"
        set -l full_path "$snippet_dir/$relative_file"
        switch $exit_status
            case 0
                foot --app-id foot-snip -e nvim "$full_path"
            case 10
                wl-copy <"$full_path"
                notify-send "Snippet Copied" "$relative_file" -i edit-copy

        end
    end

end
