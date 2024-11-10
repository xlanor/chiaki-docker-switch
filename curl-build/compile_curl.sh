#! /bin/bash
# Clean output
cd /output
rm -rf *
cd /switch/curl
yes | PKGDEST=/output/packages makepkg --syncdeps --install
mv *.tar.xz /output
sudo chown -R 777 /output