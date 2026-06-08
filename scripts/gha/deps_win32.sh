#!/bin/bash

. scripts/lib.sh

curl -L "http://libsdl.org" -o SDL2.zip
unzip -q SDL2.zip
mv "SDL2-$SDL_VERSION" SDL2_VC

if [ "$GH_CPU_ARCH" = "i386" ]; then
	rustup target add i686-pc-windows-msvc
fi

# FIX 1: Use a clean .zip build of pkgconf designed for native Windows 
curl -L "https://github.com" -o pkgconf.tar.xz
7z x pkgconf.tar.xz -y
7z x pkgconf.tar -y
rm pkgconf.tar*
mv pkgconf-2.1.1 pkgconf

# FIX 2: Explicitly query Gyan.dev architecture layouts matching your $FFMPEG_ARCHIVE variable string
FFMPEG_ARCHIVE=$(get_ffmpeg_archive)
curl -L "https://gyan.dev" -o ffmpeg.zip

if [ -f ffmpeg.zip ]; then
	unzip -q ffmpeg.zip
	mv "$FFMPEG_ARCHIVE" ffmpeg
fi
