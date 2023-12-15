#!/bin/sh

set -a

CHECK=$1
LATEST_TAG_ONLY=$2
RELEASE=$3
GIT_USER=$4
GIT_USER_EMAIL=$5
COG_EXE=$6

echo "COG_EXE: $COG_EXE"

echo "Setting git user : $GIT_USER"
git config --global user.name "$GIT_USER"

echo "Settings git user email $GIT_USER_EMAIL"
git config --global user.email "$GIT_USER_EMAIL"


if [ "$CHECK" = "true" ]; then
  if [ "$LATEST_TAG_ONLY" = "true" ]; then
    if [ "$(git describe --tags --abbrev=0)" ]; then
      message="Checking commits from $(git describe --tags --abbrev=0)"
    else
      message="No tag found checking history from first commit"
    fi
    echo "$message"
    $COG_EXE check --from-latest-tag || exit 1
  else
    echo "Checking all commits"
    $COG_EXE check || exit 1
  fi
fi

if [ "$RELEASE" = "true" ]; then
  $COG_EXE bump --auto || exit 1
  VERSION="$(git describe --tags "$(git rev-list --tags --max-count=1)")"
  echo ::set-output name=version::"$VERSION"
fi
