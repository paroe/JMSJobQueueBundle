#!/bin/bash

# Usage example:
#
#   ./rsync_with_folder.sh ~/Repositories/betterbusiness/salestracking-indiana/vendor/ezsystems/job-queue-bundle/JMS/JobQueueBundle
#
# Usage example with a higher refresh rate:
#
#   ./rsync_with_folder.sh ~/Repositories/betterbusiness/salestracking-indiana/vendor/ezsystems/job-queue-bundle/JMS/JobQueueBundle 2
#
# This will sync the folder with another folder on this machine. This is useful when
# you want to edit the bundle here and execute it in another project folder, without
# having to composer install in the other folder.

# Get destination from args
DEST=$1

# Speed is either argument two, or 5 seconds as default
SPEED=${2:-5}

# If speed is not an integer, exit
if ! [[ "$SPEED" =~ ^[0-9]+$ ]]; then
    echo "Speed must be an integer"
    exit 1
fi

echo "Keeping $DEST updated with the current folder\n"
echo "Checking if the other folder is a JMSJobQueueBundle folder by checking composer.json...\n"

if [ ! -d "$DEST" ]; then
    echo "Folder $DEST does not exist"
    exit 1
fi

PACKAGE_NAME="ezsystems/job-queue-bundle"
FILE_TO_CHECK="$DEST/composer.json"
NAME_FOUND=$(grep -E "\"name\": +\"$PACKAGE_NAME\"" $FILE_TO_CHECK | wc -l)

if [ $NAME_FOUND -eq 0 ]; then
    echo "Folder $DEST does not seem to be a JMSJobQueueBundle folder"
    exit 1
fi

echo "Okay! I can confirm that this is a JMSJobQueueBundle folder."
echo "I will now start to copy this folder's content to the other folder.\n"
echo "\n"
echo "Press Ctrl+C to stop this script.\n"

# Copy the files to DEST until the user stops the script
while true
do
    rsync -avz --exclude '.git' --exclude 'vendor' --exclude 'node_modules' ./* $DEST
    sleep $SPEED
done
