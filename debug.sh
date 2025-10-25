#!/bin/bash -eux
my_path="$(dirname "$(readlink -f "$0")")"

: "${FR24INI:=$my_path/fr24feed.ini}"

podman run \
	--rm \
	-it \
	--net=host \
	--volume "$FR24INI:/etc/fr24feed.ini:rw" \
	--device "$FR24USB" \
	"$@" \
	fr24 \
	/bin/bash
