#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)

export KUBECONFIG="${SCRIPT_DIR}/.kube/config"
