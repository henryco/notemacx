#!/bin/bash

# Define the original location of init.el
original_location="${HOME}/.emacs.d/init.el"

# The new location is the current directory of the script
new_location="${PWD}/init.el"

# Check if the original file exists
if [ -f "$original_location" ]; then
    # Delete the original init.el file
    echo "Deleting init.el at $original_location..."
    rm $original_location
else
    echo "The file $original_location does not exist. Proceeding to create symlink."
fi

# Create a symbolic link in the original location pointing to the new location
echo "Creating a symbolic link at $original_location..."
ln -s $new_location $original_location

# Check if the symlink creation was successful
if [ -L "$original_location" ]; then
    echo "Symlink created successfully."
else
    echo "Symlink creation failed."
    exit 1
fi
