#!/bin/bash
#
export PATH="/opt/x-tools/$TC/bin:$PATH"
if [ -z $RPI_IP ]
then
    echo "WARNING: please set the environment variable RPI_IP when starting this container"
elif [[ ! -f ~/.ssh/config  ]]
then
    echo "env RPI_IP: $RPI_IP"
    printf "Host rpi\n    HostName $RPI_IP\n    User pi" >> ~/.ssh/config
else
    echo "env RPI_IP: $RPI_IP"
    echo ">>The rpi server has been set"
    echo ">>The rpi information:"
    cat ~/.ssh/config | grep -A2 rpi
fi

echo "env ARCH: $ARCH"
echo "env RELEASE: $RELEASE"
echo "env TC: $TC"
echo "meson version: " $(meson --version)

/bin/bash
