#!/bin/bash
# aws configure --profile kayode
# then export the profile below
export AWS_PROFILE=kayode
# aws ecr create-repository --repository-name node-sample-app --region us-east-1
# eksctl create cluster --name msc-helm-cluster --version 1.27 --region us-east-1 --zones=us-east-1a,us-east-1b --nodegroup-name Linux-nodes --nodes 2 --nodes-min 1 --nodes-max 2 --node-type t2.micro --node-volume-size 8 --managed
aws cloudformation create-stack --stack-name ecs-eks-resource --template-body file://ecr_eks_template.yaml --parameter file://ecr_eks_template.json --region=us-east-1 --capabilities CAPABILITY_NAMED_IAM
