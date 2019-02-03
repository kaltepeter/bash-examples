#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace

echo -e "\e[96mInstalling helm. View guide: https://docs.helm.sh/using_helm/#quickstart-guide\e[39m"
kubectl config use-context docker-for-desktop
(command -v helm) || brew install kubernetes-helm
helm init
