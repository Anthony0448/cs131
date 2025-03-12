#!/bin/bash

# To do
# Schedule backups
# Cleanup old backups after some days
# Use functions in switch
# Make user prompt which directory to go into instead of just $HOME?
# Possibly implement a search feature to pull up backups of a specific date
# Add backup and delete non compressed version

# Function that updates current_time variable each time it is called
get_current_time() {
    # Variable that's value is set to the $date command output
    # Full date and current Time
    current_time=$(date "+%F-%T")

    return
}

CompressBackup() {
    if [ ! -d "$HOME"/Backups ]; then
        echo "$HOME/Backups does not exist...making directory"

        mkdir "$HOME"/Backups
    else
        echo "$HOME/Backups exists...continuing with backup"
    fi

    # Get the basename
    selectedFileBasename=$(basename "$selectedFile")
    selectedFileDirname=$(dirname "$selectedFile")

    # Call function to update variable to current time
    get_current_time

    # Use gzip for fast compression with decent size shrinking ; also installed by default
    # -c makes a new archive
    # -z utilizes the gzip compression algorithm
    # -f lets us choose the filename for the backup
    # -C specify directory to get file to compress

    # $selectedFileDirname gets the directory path ecluding the file and $selectedFileBasename is the name of the file
    # This is needed otherwise when exporting it nests the output into folders
    tar -vczf "$HOME"/Backups/"$selectedFileBasename"-"$current_time".tar.gz -C "$selectedFileDirname" "$selectedFileBasename"
}

DecompressBackup() {
    if [ ! -d "$HOME"/Backups ]; then
        echo "$HOME/Backups does not exist...making directory"

        mkdir "$HOME"/Backups
    else
        echo "$HOME/Backups exists...continuing with backup"
    fi

    echo "Files and directories in $HOME/Backups"

    items=("$HOME"/Backups/*)
    names=("${items[@]##*/}") # Extract just the names ; ##*/ removes between and including the last '/'

    echo "Select the file you would like to work with:"

    select name in "${names[@]}"; do
        # -n ensures the selection is nonempty
        if [[ -n "$name" ]]; then
            # Set $selectedFile to the the full path by adding $HOME beofre $name. Needed for if statements to work
            selectedFile="$HOME/Backups/$name"

            # If directory
            if [ -f "$selectedFile" ]; then
                echo "You selected the compressed file: $name"

                break
            fi
        else
            echo "Invalid selectedFile. Try again."
        fi
    done

    # Use the selected directory in your script
    echo "Proceeding with the selection: $selectedFile"

    # Line break for clarity
    echo ""

    # Extract compressed file
    # -v for verbose to see where the file is extracted to
    # -x to extract compressed file
    # -z to use gzip decompression
    # -f to specify the file to decompress
    # -C is needed to specify the folder where the extractions will be
    tar -vxzf "$selectedFile" -C "$HOME"/Backups/
}

# Make it so the backups have the time and date in their names
options=("Backup & compress" "Backup, compress, & delete non-compressed" "Decompress backup")

select selectedOption in "${options[@]}"; do
    if [[ -n "$selectedOption" ]]; then
        echo "You picked: $selectedOption"
        break
    else
        echo "Invalid selectedFile. Try again."
    fi
done

# Line break for clarity
echo ""

# Make sure if decompress is selected then skip this whole chunk otherwise prompt to select file to backup
if [[ "$selectedOption" != "Decompress backup" ]]; then

    # List all files and directories (names only not exact path for display)
    # This array holds the full paths for the files in $HOME
    echo "Files and directories in $HOME"
    items=("$HOME"/*) # Array of full paths in $HOME

    # Each element in ${names[]} represents an element in ${items[]}, but only the name not the full path
    names=("${items[@]##*/}") # Extract just the names ; ##*/ removes between and including the last '/'

    echo "Select the file you would like to work with:"

    # Use select to provide an interactive menuu for selecting a directory instead of typing full path
    select name in "${names[@]}"; do
        # -n ensures the selection is nonempty
        if [[ -n "$name" ]]; then
            # Set $selectedFile to the the full path by adding $HOME beofre $name. Needed for if statements to work
            selectedFile="$HOME/$name"

            # If file is a directory
            if [ -d "$selectedFile" ]; then
                echo "You selected the directory: $name"

                break
            # If file type
            elif [ -f "$selectedFile" ]; then
                echo "You selected the file: $name"

                break
            else
                echo "Invalid selectedFile. Try again."
            fi
        else
            echo "Invalid selectedFile. Try again."
        fi
    done

    # Use the selected directory in your script
    echo "Proceeding with the selection: $selectedFile"

    # Line break for clarity
    echo ""
fi

# Switch statement for the menu options
# Add functions numbnuts
case "$selectedOption" in
"Backup & compress")
    CompressBackup
    ;;
"Backup, compress, & delete non-compressed") ;;
"Decompress backup")
    DecompressBackup
    ;;
# End case options
esac
