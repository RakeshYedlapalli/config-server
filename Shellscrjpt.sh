#!/bin/bash

set -e  # Exit on first error

if [ "$COMPONENT_TESTS_SKIP" = "true" ]; then
  echo "Skipping Component Tests..."; exit 0;
fi

echo "Running component tests for $COMPONENT_TESTS_PACKAGE"

BASE_CMD="mvn verify -P $COMPONENT_TESTS_MVN_PROFILE -Dtest=$CUCUMBER_MAIN_CLASS"
BASE_CMD="$BASE_CMD -Dsurefire.failIfNoSpecifiedTests=false -am -Dcucumber.plugin=json:$CUCUMBER_REPORT_FILE"

if [ -n "$CUCUMBER_TAG" ]; then
  BASE_CMD="$BASE_CMD -Dcucumber.filter.tags=\"$CUCUMBER_TAG\""
fi

echo "Final command: $BASE_CMD"
eval $BASE_CMD

mvn allure:report
echo "✅ Component tests completed."
