## Build Docker image

`docker buildx create --use --name insecure-builder --buildkitd-flags '--allow-insecure-entitlement security.insecure'`

```
_tag=$(git describe --tags)
docker buildx build --allow security.insecure -t aarch64-rpi4-bullseye-cross-compiler-2204:$_tag --load .
```


## run container

`bash run_docker_rpi_corss_compiler.sh`

## usage

- put the built toolchain in /opt/x-tools/
- using `sbuild-apt rpi-$RELEASE-$ARCH apt-get install xxx` to install package in `~/sys/chroots/`

### cmake

```
cmake -S . -B build -DCMAKE_TOOLCHAIN_FILE=cmake/$TC.cmake
cmake --build build -j
cmake --install build
```

### meson

```
meson setup --cross-file rpi_cross_file.txt build
meson compile -C build
```

## reference

https://randdevnotes.blogspot.com/2023/10/rpi4-cross-compile-for-libcamera-app-on_24.html




