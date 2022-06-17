#!/bin/bash
# script to create, update & delete aws cloudformation stacks.

create_stack(){
  echo "Create Stack"
  read -p "Stack name: " stackName
  read -p "Template file name: " tempName
  read -p "Params JSON file name: " paramName
  aws cloudformation create-stack \
  --stack-name $stackName \
  --template-body file://$tempName \
  --parameters file://$paramName \
  --region=us-east-1 \
  --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM"
}

update_stack(){
  echo "Update stack"
  read -p "Stack name: " stackName1
  read -p "Template file name: " tempName2
  read -p "Params JSON file name: " paramName2
  aws cloudformation update-stack \
  --stack-name $stackName1 \
  --template-body file://$tempName2 \
  --parameters file://$paramName2 \
  --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
  --region=us-east-1
}

delete_stack(){
  read -p "Stack name: " stackName2
  aws cloudformation delete-stack \
  --stack-name $stackName2
  echo "Stack deleted."
}

run(){
  read -p "Select operation [create/update/delete]: " opt
  case $opt in
    create)
      create_stack
      ;;
    update)
      update_stack
      ;;
      delete)
      delete_stack
      ;;
    *)
      echo "Error: unknown option"
      run
      ;;
  esac
}
run
