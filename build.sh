#!/bin/bash -eux
podman build --build-arg-file "$(uname -m).conf" . -t fr24
