#!/usr/bin/env bash

set -euo pipefail

# get the secret associated with the default serviceaccount in the current namespace
secret=$(kubectl get serviceaccount default -o=jsonpath='{.secrets[0].name}')

# get the current context name
cluster=$(kubectl config view --minify -o=jsonpath='{.clusters[0].name}')
server=$(kubectl config view --minify -o=jsonpath='{.clusters[0].cluster.server}')

f=$(mktemp)
# get the ca.crt key from the secret, decode it, and store in file
kubectl get secret ${secret} -o=jsonpath='{.data.ca\.crt}' | base64 -d > ${f}

# modify cluster
kubectl config set-cluster ${cluster} --server=${server} --certificate-authority=${f} --embed-certs
