#!/bin/bash
GIT_HASH=$(shell git rev-parse HEAD | head -c 10)

echo $1 | gpg \
       --passphrase-fd 0 \
       --batch --yes \
       --no-default-keyring --armor \
       --secret-keyring ./unixvoid.sec --keyring ./unixvoid.pub \
       --output unixvoid_blog-$GIT_HASH-linux-amd64.aci.asc \
       --detach-sig unixvoid_blog.aci

mv unixvoid_blog.aci unixvoid_blog-$GIT_HASH-linux-amd64.aci
