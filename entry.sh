#!/usr/bin/env bash

# entrypoint for ssh
# this is needed to start the ssh service

set -xe

service ssh start
service ssh status

exec "$@"

