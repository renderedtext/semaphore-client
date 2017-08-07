#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

LOCAL_VERSION=$(cat lib/semaphore_client/version.rb | grep VERSION | cut -d " " -f 5 | tr -d '""')
REMOTE_VERSION=$(fury list --as=renderedtext | grep "semaphore_client" | cut -d " " -f 2 | tr -d '()')

if [ $LOCAL_VERSION = $REMOTE_VERSION ]; then
  echo "Version ${LOCAL_VERSION} already exists.";
  exit 1;
fi
