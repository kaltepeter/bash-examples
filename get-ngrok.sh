#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace
readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

curl -o "${__dir}/ngrok-stable-darwin-amd64.zip" https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-darwin-amd64.zip
unzip "${__dir}/ngrok-stable-darwin-amd64.zip" -d "/usr/local/bin/"
rm "${__dir}/ngrok-stable-darwin-amd64.zip"
chmod +x "/usr/local/bin/ngrok"
