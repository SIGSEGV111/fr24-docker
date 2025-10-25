#!/bin/bash -eux
my_path="$(dirname "$(readlink -f "$0")")"

: "${FR24INI:=$my_path/fr24feed.ini}"

touch "$FR24INI"
"$my_path/build.sh"
podman run \
	--rm \
	-it \
	--volume "$FR24INI:/etc/fr24feed.ini:rw" \
	fr24 \
	/usr/bin/fr24feed-signup-adsb
