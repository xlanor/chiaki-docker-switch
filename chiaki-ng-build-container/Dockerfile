#https://github.com/devkitPro/pacman/releases
FROM docker.io/archlinux/archlinux:base-devel-20241109.0.278052

ENV DEVKITPRO=/opt/devkitpro
ENV DEVKITARM=/opt/devkitpro/devkitARM
ENV DEVKITPPC=/opt/devkitpro/devkitPPC
ENV PATH="${PATH}:${DEVKITARM}/bin/:${DEVKITPPC}/bin/"

ENV WORKDIR="/build"
WORKDIR "${WORKDIR}"

RUN pacman-key --init
# Install devkitpro
# doc source :
# https://devkitpro.org/wiki/devkitPro_pacman

# First import the key which is used to validate the packages
RUN pacman-key --recv BC26F752D25B92CE272E0F44F7FD5492264BB9D0 --keyserver keyserver.ubuntu.com && \
		pacman-key --lsign BC26F752D25B92CE272E0F44F7FD5492264BB9D0

RUN pacman --noconfirm -U https://downloads.devkitpro.org/devkitpro-keyring.pkg.tar.xz
ADD devkit_repo ./devkit_repo
RUN cat ./devkit_repo >> /etc/pacman.conf

# Now resync the database and update installed packages.
# And install requirements
RUN pacman --noconfirm -Syu && \
	pacman --noconfirm -Su \
		git \
		pkg-config \
		make \
		ninja \
		cmake \
		gcc \
		vim \
		protobuf \
		fftw \
		python-protobuf \
		lib32-glibc \
		devkitARM \
		switch-pkg-config \
		dkp-toolchain-vars \
		switch-dev \
		switch-zlib \
		switch-sdl2 \
		switch-freetype \
		switch-glfw \
		switch-mesa \
		switch-glad \
		switch-glm \
		switch-libconfig \
		switch-sdl2_gfx \
		switch-sdl2_ttf \
		switch-sdl2_image \
		switch-sdl2_mixer \
		switch-libexpat \
		switch-bzip2 \
		switch-libopus \
		switch-ffmpeg \
		switch-libjson-c \
		switch-mbedtls \
		switch-miniupnpc  && \
		yes | pacman -Scc

# the `pacman --noconfirm -Scc` command
# does not assume yes on /var/cache/pacman/pkg/
RUN useradd --no-create-home --shell=/bin/false build && usermod -L build
RUN echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Install compiled curl
USER build
COPY --chown=build:build output/packages /switch-curl
COPY --chown=build:build switch/curl/PKGBUILD /switch-curl/PKGBUILD
WORKDIR /switch-curl
RUN yes | makepkg --syncdeps --install

USER root
# Reset the workdir
WORKDIR ${WORKDIR}

VOLUME ${WORKDIR}

# nxlink server port
EXPOSE 28771
CMD ["/bin/bash"]
