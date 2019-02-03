#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace
readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
(command -v ngrok) || bash "${__dir}/get-ngrok.sh"

# start ngrok
readonly ngrok_pid="${__dir}/ngrok-pid.txt"
ps -p "$(cat "${ngrok_pid}")" && kill -9 "$(cat "${ngrok_pid}")"
nohup ngrok start jenkins &
echo $! > "${ngrok_pid}"
