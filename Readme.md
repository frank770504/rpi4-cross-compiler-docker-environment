## Build Docker image

`docker buildx create --use --name insecure-builder --buildkitd-flags '--allow-insecure-entitlement security.insecure'`

`docker buildx build --allow security.insecure -t aarch64-rpi4-bullseye-cross-compiler-2204:v0.1.3 --load .`

## run container

`bash run_docker_rpi_corss_compiler.sh`

## usage

- put the built toolchain in /opt/x-tools/
- using `sbuild-apt rpi-$RELEASE-$ARCH apt-get install xxx` to install package in `~/sys/chroots/`
- using rsync to sync the `chroots` to the `sysroot`, built from toolchain`.

```
~ cd /opt/x-tools/aarch64-rpi4-linux-gnu/aarch64-rpi4-linux-gnu/sysroot
~ rsync -rzL --safe-links ~/sys/chroots/rpi-bullseye-arm64/lib/ ./lib
~ rsync -rzL --safe-links ~/sys/chroots/rpi-bullseye-arm64/usr/lib/ ./usr/lib
~ rsync -rzL --safe-links ~/sys/chroots/rpi-bullseye-arm64/usr/include/ ./usr/include/
```

## All the path I go through, that I haven't organize all the information

https://mousy-brain-150.notion.site/RPI-Cross-compiler-59002cbdaaa144c58ab3d301aee5ba82?pvs=4




