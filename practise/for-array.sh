#!/bin/bash

devops_tools=("docker" "kubernetes" "ansible" "terraform" "jenkins")

for denyo in ${devops_tools[@]}
do
    echo $denyo
done