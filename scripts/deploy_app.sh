#!/usr/bin/env bash

helm package $HELM_CHART_NAME
export HELM_EXPERIMENTAL_OCI=1
helm push $HELM_CHART_NAME-0.1.0.tgz oci://$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/
echo "oci://$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$HELM_CHART_NAME"
helm upgrade --install $HELM_CHART_NAME oci://$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$HELM_CHART_NAME
