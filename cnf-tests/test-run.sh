#!/bin/bash
set -e
# Setting -e is fine as we want both config and validiation to succeed
# before running the "real" tests.

suites=(validationsuite configsuite cnftests)
SUITES_PATH="${SUITES_PATH:-~/usr/bin}"

if [ "$IMAGE_REGISTRY" != "" ] && [[ "$IMAGE_REGISTRY" != */ ]]; then
    export IMAGE_REGISTRY="$IMAGE_REGISTRY/"
fi

for suite in "${suites[@]}"; do
    if [ "$DISCOVERY_MODE" == "true" ] &&  [ "$suite" == "configsuite" ]; then
        echo "Discovery mode enabled, skipping setup"
        continue
    fi
    echo running "$SUITES_PATH/$suite" "$@"
    "$SUITES_PATH/$suite" "$@"
done
