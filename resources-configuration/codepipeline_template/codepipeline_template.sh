#!/bin/bash
export AWS_PROFILE=kayode
aws cloudformation create-stack --stack-name create-codepipeline-resource --template-body file://codepipeline_template.yaml --parameter file://codepipeline_template.json --region=us-east-1 --capabilities CAPABILITY_NAMED_IAM

# chmod +x codepipeline_template.sh
# ./codepipeline_template.sh create-codepipeline-resource codepipeline_template.yaml codepipeline_template.json
# ./codepipeline_template.sh
