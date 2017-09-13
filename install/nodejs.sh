#!/usr/bin/env bash

NODE_VERSION="8.2.1"

wget https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz -O /home/admin/pkg/node-v${NODE_VERSION}-linux-x64.tar.xz
cd /home/admin/pkg
tar -Jvxf node-v${NODE_VERSION}-linux-x64.tar.xz
mv /home/admin/pkg/node-v${NODE_VERSION}-linux-x64 /home/admin/pkg/node