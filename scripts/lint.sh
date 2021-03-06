#!/bin/bash
set -eux

SRCROOT="$(cd "$(dirname "$0")/.." && pwd)"

for dir in $(find $SRCROOT/charts -mindepth 1 -maxdepth 1 -type d);
do
 name=$(basename $dir)
 echo "Running Helm linting for $name"
 docker run \
    -v "$SRCROOT:/workdir" \
    gcr.io/kubernetes-charts-ci/test-image:v3.0.1 \
    ct \
    lint \
    --config .circleci/chart-testing.yaml \
    --lint-conf .circleci/lintconf.yaml \
    --charts "/workdir/charts/${name}"
done
