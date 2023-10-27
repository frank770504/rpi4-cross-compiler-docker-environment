#!/bin/bash


_should_start_buildx=1
_container_list=$(docker ps --format '{{.Names}}')
for c in $_container_list;
do
    if [[ $c == *"insecure-builder"* ]];
    then
        echo there is a contianer of $c
        _should_start_buildx=0
    fi
done

if $_should_start_buildx;
then
    echo "start buildx"
    docker buildx create --use --name insecure-builder --buildkitd-flags '--allow-insecure-entitlement security.insecure'
else
    echo "buildx has been exist"
fi
_tag=$(git describe --tags)
docker buildx build --allow security.insecure -t aarch64-rpi4-bullseye-cross-compiler-2204:$_tag --load .
