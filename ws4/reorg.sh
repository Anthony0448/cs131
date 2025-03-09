#!/bin/bash

# Function that updates current_time variable each time it is called
get_current_time() {
    # Variable that's value is set to the $date command output
    current_time=$(date "+%F-%T")

    return
}

# Call function to update variable to current time
get_current_time

# Using environment variable for home since this is a script and home directory can vary
# Environment variable is wrapped in double quotes to prevent splitting

# Explaining command:
# The sed command helps manipulate a given input. In this case the .csv file is being inputted...
# where the sed command will manipulate the input to only contain lines matching a specific vendorid
# -n prevents printing the output to the terminal
#
sed -n '/^1\.0,/p' "$HOME"/cs131/2019-01-h1.csv >"$HOME"/cs131/ws4/"$current_time".csv

# Check if the .csv file is made
if [ -f "$HOME"/cs131/ws4/"$current_time".csv ]; then
    # Double double quotes for environmental variables that already were in quotes
    echo "File created: ""$HOME""/cs131/ws4/""$current_time"".csv"""
else
    echo "Error creating file ""$current_time"".csv"
fi

# Line break
echo ""

# Call function to update variable to current time after first file is made
get_current_time

sed -n '/^2\.0,/p' "$HOME"/cs131/2019-01-h1.csv >"$HOME"/cs131/ws4/"$current_time".csv

# Check if the .csv file is made
if [ -f "$HOME"/cs131/ws4/"$current_time".csv ]; then
    echo "File created: ""$HOME""/cs131/ws4/""$current_time"".csv"""
else
    echo "Error creating file ""$current_time"".csv"
fi

# Line break
echo ""

# Call function to update variable to current time after first file is made
get_current_time

sed -n '/^4\.0,/p' "$HOME"/cs131/2019-01-h1.csv >"$HOME"/cs131/ws4/"$current_time".csv

# Check if the .csv file is made
if [ -f "$HOME"/cs131/ws4/"$current_time".csv ]; then
    echo "File created: ""$HOME""/cs131/ws4/""$current_time"".csv"""
else
    echo "Error creating file ""$current_time"".csv"
fi

# Line break
echo ""

# For every .csv file in current directory, add it to the .gitignore
# No ./ precedes the '*.csv' because .gitignore does not ignore files in current directory...
# if they start with anything besides the exact file name such as, ./2025-00-00.csv
for file in *.csv; do
    # $ echo is used to append each name (echo output) to the .gitignore
    # Added to a local .gitignore
    echo "$file" >>./.gitignore

    echo "File added to .gitignore: ""$file"""
done
