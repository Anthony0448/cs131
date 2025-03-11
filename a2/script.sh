#!/bin/bash

# List all files and directories (names only not exact path for display)
echo "Files and directories in $HOME:"
items=("$HOME"/*) # Array of full paths in $HOME

# ##*/ removes between and including the last '/'
names=("${items[@]##*/}") # Extract just the names

echo "Select the server directory you would like to update:"

# Use select to display only the names
select name in "${names[@]}"; do
    if [[ -n "$name" ]]; then
        # Map the name back to the full path
        choice="$HOME/$name"

        # If directory
        if [ -d "$choice" ]; then
            echo "You selected the directory: $choice"
            break
        # If file
        elif [ -f "$choice" ]; then
            echo "You selected a file. Please select a directory."
        else
            echo "Invalid choice. Try again."
        fi
    else
        echo "Invalid choice. Try again."
    fi
done

# Use the selected directory in your script
echo "Proceeding with the directory: $choice"
