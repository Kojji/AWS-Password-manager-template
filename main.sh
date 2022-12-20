#!/bin/bash
# Variables to set
DBClusterName="app-test-cluster"
createTableFunction="app-test-create-tables-function"

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
  sam.cmd deploy --guided --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND --template templates/template.yaml --parameter-overrides DBTableCreationFunctionName="${createTableFunction}" DBClusterName="${DBClusterName}"
  aws lambda invoke --function-name ${createTableFunction} log-output --log-type Tail --query 'LogResult' --output text |  base64 -d

else
  echo "Running deployment!"
  sam.cmd deploy --template templates/template.yaml
fi
