Changes:
- autoconf 2.72 breaks with cross compilation, check this [issue](https://github.com/curl/curl/issues/5126). Bumped to curl 8.11.0.
- Use mbedtls for now rather than libnx because there's so much code in chiaki-ng using mbedtls and I have no idea whats going on yet. The idea is to get a working build first.
- Enable wss support in curl (by default in curl 8.11.0)
