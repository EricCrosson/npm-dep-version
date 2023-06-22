#!/usr/bin/env bash
#
# Print the currently-installed version of the specified npm package.
#
# Usage:
#  npm-dep-version <package-name>
#
# @example
# npm-dep-version fp-ts

set -o errexit
set -o nounset
set -o pipefail

usage() {
  cat <<EOF

  Usage:
    npm-dep-version <package-name>
EOF
}

# Parse arguments
package_name=""

while [[ ${1:-} != "" ]]; do
  case $1 in
  -h | --help)
    usage
    exit 1
    ;;
  *)
    package_name=$1
    shift # past value
    ;;
  esac
done

# Validate arguments
validation_errors=false

if [[ -z $package_name ]]; then
  echo >&2 "Error: must supply <package-name>"
  validation_errors=true
fi

if [[ $validation_errors == true ]]; then
  usage
  exit 1
fi

main() {
  node -e "console.log(require('${package_name}/package.json').version)"
}

main
