#!/usr/bin/env bash

# This script will install EKS prerequisites on Amazon Linux or Amazon Linux 2
# * kubectl
# * aws-iam-authenticator
# * AWS CLI
# * eksctl
# * helm

set -e

mkdir -p $HOME/bin
echo 'export PATH=$HOME/bin:$PATH' >>~/.bashrc

# Install kubectl, if absent
if ! type kubectl >/dev/null 2>&1; then
	curl -o "kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.27.1/2023-04-19/bin/linux/amd64/kubectl"
	chmod +x ./kubectl
	cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
	echo 'kubectl installed'
else
	echo 'kubectl already installed'
fi

# aws-iam-authenticator
if ! type aws-iam-authenticator >/dev/null 2>&1; then
	curl -Lo aws-iam-authenticator "https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.5.9/aws-iam-authenticator_0.5.9_linux_amd64"
	chmod +x ./aws-iam-authenticator
	cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH
	echo 'aws-iam-authenticator installed'
else
	echo 'aws-iam-authenticator already installed'
fi

# AWS CLI
if ! type aws >/dev/null 2>&1; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    ./aws/install -b $HOME/bin/aws
	echo 'AWS CLI installed'
else
	echo 'AWS CLI already installed'
fi

# eksctl
if ! type eksctl >/dev/null 2>&1; then
	curl --silent --location "https://github.com/eksctl-io/eksctl/releases/download/v0.149.0/eksctl_Linux_amd64.tar.gz" | tar xz -C /tmp
	mv /tmp/eksctl $HOME/bin
	echo 'eksctl installed'
else
	echo 'eksctl already installed'
fi

# helm
if ! type helm >/dev/null 2>&1; then
	curl -L https://get.helm.sh/helm-v3.12.0-linux-amd64.tar.gz | tar xz
	mv linux-amd64/helm $HOME/bin/helm
	rm -rf linux-amd64
	echo 'helm installed'
else
	echo 'helm already installed'
fi

# Test if AWS credentials exist
aws sts get-caller-identity
