#!/bin/bash
_source=/Users/frankchen/Code/rpi_test
_docker_source=/root/main
_test_source=/Users/frankchen/Code/rpi_test_data
_docker_test_source=/root/test_data
_ssh_dir=./ssh
_docker_ssh_dir=/root/.ssh

_tag=$(git describe --tags)
_docker_image=aarch64-rpi4-bullseye-cross-compiler-2204:$_tag
_docker_volume=docker_build_rpi
_docker_volume_toolchain=rpi4-toolchain
#_docker_volume_sysroot=sys-aarch64-linux-gnu
_docker_volume_crosstool_ng=crosstoll_ng

#           --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \

if [[ -f ./ssh/config ]]
then
    rm ./ssh/config
fi

docker run -it --rm \
           --privileged=true \
           --cap-add=SYS_ADMIN --security-opt apparmor:unconfined \
           -e RPI_IP=$1 \
           -v $_docker_volume:/root/build \
           -v $_docker_volume_toolchain:/opt \
           -v $_docker_volume_crosstool_ng:/root/crosstool_ng \
           -v $_source:$_docker_source:delegated \
           -v $_test_source:$_docker_test_source:delegated \
           -v $_ssh_dir:$_docker_ssh_dir:delegated \
           --net=host \
           $_docker_image bash
