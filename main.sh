#!/bin/bash
guided=false
while getopts g flag
do
  case "${flag}" in
    g) guided=true;;
  esac
done
if [ $guided == true ]
then
  echo "Running guided deployment!"
  sam.cmd deploy --guided --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND --template templates/template.yaml
else
  echo "Running deployment!"
  sam.cmd deploy --template templates/template.yaml
fi
# trigger lambda function after dedploy