#!/bin/bash
# aws configure --profile kayode
# then export the profile below
export AWS_PROFILE=kayode
aws cloudformation create-stack --stack-name create-codepipeline-resource --template-body file://codepipeline_template.yaml --parameter file://codepipeline_template.json --region=us-east-1 --capabilities CAPABILITY_NAMED_IAM
