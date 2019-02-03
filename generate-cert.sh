#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace
readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<END
./configure-ssl.sh [-h] domain

Generate self signed cert for domain.
    domain: the domain to generate a cert for
    -h: show this help message
END
}

while getopts "h" opt; do
  case $opt in
  h)
    usage
    exit 0
    ;;
  \?)
    echo "Invalid option: -$OPTARG" >&2
    exit 1
    ;;
  :)
    echo "Option -$OPTARG requires an argument." >&2
    exit 1
    ;;
  esac
done

domain="${1:-}"
[[ -z ${domain} ]] && {
  echo -e "\e[31mmissing first argument for domain which is required\e[39m"
  exit 1
} || echo -e "\e[36mconfigure ssl for: ${domain}\e[39m"

openssl req -x509 -out "${domain}".crt -keyout "${domain}".key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj "/CN=${domain}" -extensions EXT -config <( \
   printf "[dn]\nCN=%s\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:%s\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth" "${domain}" "${domain}")
