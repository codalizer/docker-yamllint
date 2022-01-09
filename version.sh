#!/usr/bin/env bash

VERSION=latest
GITHUB_REF=$(git branch --show-current)

if [ -z "${GITHUB_REF}" ]; then
	GITHUB_REF=$(git name-rev --name-only HEAD)
fi

if [ "main" = "$GITHUB_REF" ]; then
	# If on main, change the version to `edge`
	VERSION=edge
elif [[ -n "${GITHUB_REF}" ]]; then
	# If a git head is found, replace `/` with `-` and return
	VERSION=$(echo "${GITHUB_REF}" | sed -r 's#/+#-#g')

	# If the version contains `tags-`, trim it
	VERSION=${VERSION#tags-v}
fi

echo "${VERSION}"