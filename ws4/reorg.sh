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
sed -n '/^[1.0,]/ p' "$HOME"/cs131/2019-01-h1.csv >"$HOME"/cs131/ws4/"$current_time".csv

# Check if the .csv file is made
if [ -f "$HOME"/cs131/ws4/"$current_time".csv ]; then
    # Double double quotes for environmental variables that already were in quotes
    echo "file ""$HOME""/cs131/ws4/""$current_time"".csv"" created!"
else
    echo "Error creating file ""$current_time"".csv"
fi

# Line break
echo ""

# Call function to update variable to current time after first file is made
get_current_time

sed -n '/^[2.0,]/ p' "$HOME"/cs131/2019-01-h1.csv >"$HOME"/cs131/ws4/"$current_time".csv

# Check if the .csv file is made
if [ -f "$HOME"/cs131/ws4/"$current_time".csv ]; then
    echo "file ""$HOME""/cs131/ws4/""$current_time"".csv"" created!"
else
    echo "Error creating file ""$current_time"".csv"
fi

# Line break
echo ""

# Call function to update variable to current time after first file is made
get_current_time

sed -n '/^[4.0,]/ p' "$HOME"/cs131/2019-01-h1.csv >"$HOME"/cs131/ws4/"$current_time".csv

# Check if the .csv file is made
if [ -f "$HOME"/cs131/ws4/"$current_time".csv ]; then
    echo "file ""$HOME""/cs131/ws4/""$current_time"".csv"" created!"
else
    echo "Error creating file ""$current_time"".csv"
fi
