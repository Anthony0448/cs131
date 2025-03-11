#!/bin/bash

# List all files and directories (names only not exact path for display)
# This array holds the full paths for the files in $HOME
echo "Files and directories in $HOME:"
items=("$HOME"/*) # Array of full paths in $HOME

# Each element in ${names[]} represents an element in ${items[]}, but only the name not the full path
names=("${items[@]##*/}") # Extract just the names ; ##*/ removes between and including the last '/'

echo "Select the server directory you would like to work with:"

# Use select to provide an interactive menuu for selecting a directory instead of typing full path
select name in "${names[@]}"; do
    if [[ -n "$name" ]]; then
        # Set $choice to the current $name element in the loop
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
