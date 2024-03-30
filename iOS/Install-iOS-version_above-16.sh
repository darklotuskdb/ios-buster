#!/bin/bash

apt-get update --fix-missing
apt-get install -y gawk nano unzip coreutils tree libplist-utils cycript lldb lldb-14 liblldb-14 --allow-unauthenticated
