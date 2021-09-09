#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)

export KUBECONFIG="${SCRIPT_DIR}/.kube/config"

PRIVATE_URL=$(cat .private_url)
PUBLIC_URL=$(cat .public_url)

echo "Public url: ${PUBLIC_URL}"
echo "Private url: ${PRIVATE_URL}"

if [[ -z "${PUBLIC_URL}" ]]; then
  echo "Public url missing"
  exit 1
fi

if [[ -z "${PRIVATE_URL}" ]]; then
  echo "Private url missing"
  exit 1
fi
