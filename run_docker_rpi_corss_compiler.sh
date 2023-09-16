#!/bin/bash
_source=/Users/frankchen/Code/rpi_test
_docker_source=/root/main
_test_source=/Users/frankchen/Code/rpi_test_data
_docker_test_source=/root/test_data

_docker_image=aarch64-rpi4-bullseye-cross-compiler-2204:v0.1.6
_docker_volume=docker_build_rpi
_docker_volume_toolchain=rpi4-toolchain
#_docker_volume_sysroot=rpi4-sys
_docker_volume_crosstool_ng=crosstoll_ng

#           --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
docker run -it --rm \
           --privileged=true \
           --cap-add=SYS_ADMIN --security-opt apparmor:unconfined \
           -v $_docker_volume:/root/build \
           -v $_docker_volume_toolchain:/opt \
           -v $_docker_volume_crosstool_ng:/root/crosstool_ng \
           -v $_source:$_docker_source:delegated \
           -v $_test_source:$_docker_test_source:delegated \
           --net=host \
           $_docker_image bash
