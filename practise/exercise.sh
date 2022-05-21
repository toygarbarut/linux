#! /bin/bash

read -p "Enter your age: " AGE
read -p "Enter your name: "  NAME 
read -p "Enter your life expectancy: " ALE

if [[ $AGE -lt 18 ]]
then 
        echo "You are student"
        echo "At least $((18-$AGE)) years later you will be worker"
elif [[ $AGE -ge 18 &&  $AGE -lt 65 ]]
then 
        echo "You are a worker"
        echo "You will be retired $((65-$AGE)) years later."
elif [[ $AGE -ge 65 ]]
then 
        if [[ $AGE -lt $ALE ]]
        then 
                echo "You will die $(($ALE-$AGE)) years later."
        else
                echo "You already died"  
        fi
fi