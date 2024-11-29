#! /bin/bash
# Clean output
cd /output
rm -rf *
# Build dav1d first,
cd /switch/dav1d
yes | PKGDEST=/output/packages/dav1d makepkg --syncdeps --install
# Build mbedtls first,
# cd /switch/mbedtls
# yes | PKGDEST=/output/packages/mbedtls makepkg --syncdeps --install
# Then build curl to link to mbedtls,
cd /switch/curl
yes | PKGDEST=/output/packages/curl makepkg --syncdeps --install
sudo chmod -R 777 /output