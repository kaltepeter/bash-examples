#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace
readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

VERSION=$(cat "${__dir}/VERSION")
INSTALLER="cloudbees-core_${VERSION}_kubernetes.tgz"
curl --fail -o "${__dir}/${INSTALLER}" "https://downloads.cloudbees.com/cloudbees-core/cloud/${VERSION}/${INSTALLER}"
curl --fail -o "${__dir}/${INSTALLER}.sha256" "https://downloads.cloudbees.com/cloudbees-core/cloud/${VERSION}/${INSTALLER}.sha256"
shasum -a 256 -c "${__dir}/${INSTALLER}.sha256"
tar xzvf "${__dir}/${INSTALLER}"
# deleting makes a fresh download everytime, just ignore
rm "${__dir}/${INSTALLER}"
