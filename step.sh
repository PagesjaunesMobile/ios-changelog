#!/bin/bash
set -ex
THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "*** Generate Changelog start ***"

#Look for destination branch commit
if [ -z "$BITRISEIO_GIT_BRANCH_DEST" ]; then
   lastLMasterTag=$(git rev-list --parents HEAD | head -1| cut -d' ' -f2)
   else
    git checkout ${BITRISEIO_GIT_BRANCH_DEST}~1
    lastLMasterTag=$(git log --pretty=format:'%h' -n 1)
fi

#Look for from branch commit
git checkout ${BITRISE_GIT_BRANCH}
lastLBranchTag=$(git log --pretty=format:'%h' -n 1)

#Generate changelog
changelog="$(git log --pretty=format:"%s" $lastLMasterTag...$lastLBranchTag)"

#Save changelog in environment variable
envman add --key CHANGELOG_TEXT --value $changelog

echo "*** Generate Changelog finish ***"
