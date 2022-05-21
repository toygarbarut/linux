#!/bin/bash

echo "Files in current folder."

for FILE in $(ls)
do
    echo $FILE
done