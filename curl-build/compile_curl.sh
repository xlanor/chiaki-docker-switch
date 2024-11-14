#! /bin/bash
# Clean output
cd /output
rm -rf *
# Build mbedtls first,
cd /switch/mbedtls
yes | PKGDEST=/output/packages/mbedtls makepkg --syncdeps --install
# Then build curl to link to mbedtls,
cd /switch/curl
yes | PKGDEST=/output/packages/curl makepkg --syncdeps --install
sudo chmod -R 777 /output