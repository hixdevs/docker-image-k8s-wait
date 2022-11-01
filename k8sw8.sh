#!/bin/bash

set -x;
WAIT_CODE="${WAIT_CODE:=200}"
WAIT_TIME="${WAIT_TIME:=5}"
WAIT_DURATION=0

if [[ -z "$WAIT_URL" ]]; then echo "Env variable 'WAIT_URL' is missing" && exit 1; fi

while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' $WAIT_URL)" != "$WAIT_CODE" ]]; do
  HTTP_STATUS_CODE="$(curl -s -o /dev/null -w ''%{http_code}'' $WAIT_URL)"
  WAIT_DURATION=$((WAIT_DURATION+WAIT_TIME))
  echo "Waiting $WAIT_DURATION seconds. Status: $HTTP_STATUS_CODE"
  sleep $WAIT_TIME;
done

echo "Success."
