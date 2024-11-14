Slightly more updated fork of the docker build base image.

- Moved from downloads.devkitpro.org to pkg.devkitpro.org and added a `${ARCH}` to url. [Wiki](https://devkitpro.org/wiki/devkitPro_pacman)
- Removed `devkitpro-pkgbuild-helpers` and replaced with `dkp-toolchain-vars` [devkitpro issues[(https://github.com/devkitPro/pacman-packages/issues/306)
- Recompiled mbedtls with `3.26.0`
- Recompiled curl with mbedtls as default ssl backend, together with latest mbedtls + websockets.
(This should hopefully be temporary until I gain enough confidence to replace it with libnx entirely.)


- `./build-curl-amd64.sh` builds a docker environment and then compiles mbedtls and curl linked to mbedtls. This is then placed in output.
- `./build-chiaki-builder.sh` then takes the output/ directory packages and prepares a chiaki compilation environment.

```
[root@db900765e76a build]# pacman -Ss switch-curl
dkp-libs/switch-curl 7.69.1-5 (switch-portlibs) [installed: 8.11.0-1]
    An URL retrieval utility and library
[root@db900765e76a build]# pacman -Ss switch-mbedtls
dkp-libs/switch-mbedtls 2.28.3-3 (switch-portlibs) [installed: 3.6.2-1]
    An open source, portable, easy to use, readable and flexible SSL library
```