#!/usr/bin/env bash
# Same implementation as https://github.com/attakei/sphinx-revealjs/blob/v1.4.4/tools/fetch_revealjs.py

set -euo pipefail

version=$1
destDirAbsolutePath=$2

if [ ! -e "${destDirAbsolutePath}" ]; then
  mkdir -p "${destDirAbsolutePath}"
else
  if [ -n "$(ls "${destDirAbsolutePath}")" ]; then
    echo 'It seems Reveal.js assets are already installed.'
    exit 0
  fi
fi

revealjsTarBallName="reveal.js-${version}.tgz"

workDir=$(mktemp -d)
cd "${workDir}"

wget "https://registry.npmjs.org/reveal.js/-/${revealjsTarBallName}"
tar -xf "${revealjsTarBallName}"

for resource in dist plugin LICENSE
do
  mv package/${resource} "${destDirAbsolutePath}"
done

cd -
rm -r "${workDir}"
