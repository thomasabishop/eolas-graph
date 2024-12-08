##!/bin/bash

#============================================================================#
# FILE: deploy_s3.sh																											   #
# USAGE: deploy_json.sh																											 #
# DESCRIPTION: Upload graph JSON																					   #
#============================================================================#

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NO_COLOR='\033[0m'

PROJECT_ROOT="/home/thomas/repos/eolas-graph"
FILE_PATH="$PROJECT_ROOT/deploy/json/graph.json"
BUCKET_NAME="eolas-graph"
BUCKET_KEY="json/graph.js"

if [ ! -f "$FILE_PATH" ]; then
	echo -e "${RED}ERROR Graph file ( $FILE_PATH ) does not exist. Exiting.${NO_COLOR}"
	exit 0
fi

echo -e "${BLUE}INFO Uploading ${FILE_PATH} ...${NO_COLOR}"

aws s3api put-object --bucket "${BUCKET_NAME}" --key "${BUCKET_KEY}" --body "${FILE_PATH}" >/dev/null 2>&1
STATUS=$?

if [ $STATUS -eq 0 ]; then
	echo -e "${GREEN}SUCCESS File uploaded.${NO_COLOR}"
else
	echo -e "${RED}ERROR Upload failed with status $STATUS.${NO_COLOR}"
fi
