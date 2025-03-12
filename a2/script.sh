#!/bin/bash

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
    # Timestamp is added to backup up files
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

    # Add the .tar.gz since the compressed files will contain this
    # items is an array of full paths in $HOME and appends .tar.gz
    # The items[@] references all elements in the array
    items=("$HOME"/Backups/*.tar.gz)
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
            echo "Invalid selection. Try again."
        fi
    done

    # Use the selected directory in your script
    echo "Proceeding with the selection: $selectedFile"

    # Line break for clarity
    echo ""

    # Show options of where to extract
    echo "Where would you like to extract the files?"
    echo "1) Extract to $HOME/Backups/extracted/"
    echo "2) Specify exact location"

    # Read input for options to store in $extract_choice
    # -r is good practice when using read in case input has an escaping character
    read -rp "Enter your selection (1 or 2): " extract_choice

    # Create directory to hold extraction while choice on where to put it is made
    extract_temp="$HOME/Backups/temp_extract"

    # Make the directory if it does not already exist
    # -p creates parent directories if needed
    mkdir -p "$extract_temp"

    # Extract $slectedFile to temp directory first since we do not know where to put it yet
    tar -xzf "$selectedFile" -C "$extract_temp"

    # Switch case for where to extract
    case $extract_choice in
    1)
        # Make extracted folder location
        mkdir -p "$HOME/Backups/extracted"

        # Move all files in the temporary extractd folder to extracted (there should only be the current extracted files)
        mv "$extract_temp"/* "$HOME/Backups/extracted/"
        echo "Files extracted to $HOME/Backups/extracted/"
        ;;
    2)
        # Let user specify a location
        read -rp "Enter the full path where you want to extract: " custom_path

        # Check if provided path is a valid directory
        if [ -d "$custom_path" ]; then
            # Move all files from the temporary folder to the specified path
            mv "$extract_temp"/* "$custom_path"

            echo "Files extracted to $custom_path"
        else
            # If the directory does not exist, then make it
            echo "Directory $custom_path doesn't exist. Creating it..."

            mkdir -p "$custom_path"

            # Move all files from the temporary folder to the specified user path
            mv "$extract_temp"/* "$custom_path"

            echo "Files extracted to $custom_path"
        fi
        ;;

    *)
        # Default case extracts to the extracted folder
        echo "Invalid choice. Extracting to $HOME/Backups/extracted/"

        mkdir -p "$HOME/Backups/extracted"

        mv "$extract_temp"/* "$HOME/Backups/extracted/"
        ;;
    esac

    # Removes anything left in the temporary folder as there should not be anything left in it for next use
    rm -rf "$extract_temp"
}

# Make it so the backups have the time and date in their names
options=("Backup & compress" "Backup, compress, & delete non-compressed" "Decompress backup")

select selectedOption in "${options[@]}"; do
    if [[ -n "$selectedOption" ]]; then
        echo "You picked: $selectedOption"
        break
    else
        echo "Invalid selection. Try again."
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
                echo "Invalid selection. Try again."
            fi
        else
            echo "Invalid selection. Try again."
        fi
    done

    # Use the selected directory in your script
    echo "Proceeding with the selection: $selectedFile"

    # Line break for clarity
    echo ""
fi

# Switch statement for the menu options
case "$selectedOption" in
"Backup & compress")
    CompressBackup
    ;;
"Backup, compress, & delete non-compressed")
    # For the compress and delete option just use CompressBackup function and then delete the specified folder
    CompressBackup

    echo "Would you like to delete the original file/directory? (y/n)"

    read -rp "> " delete_choice

    # Did not get switch case in switch case to work, so if statement it is
    # or '||' used t get either capital or lowercase
    if [[ "$delete_choice" == "y" || "$delete_choice" == "Y" ]]; then
        rm -rf "$selectedFile"
        echo "Original file/directory deleted."
    else
        echo "Original file/directory was not deleted."
    fi
    ;;
"Decompress backup")
    DecompressBackup
    ;;
# End case options
esac
