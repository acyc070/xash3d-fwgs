#!/bin/bash

. scripts/lib.sh

curl -L "http://libsdl.org/release/SDL2-devel-$SDL_VERSION-VC.zip" -o SDL2.zip
unzip -q SDL2.zip
mv "SDL2-$SDL_VERSION" SDL2_VC

if [ "$GH_CPU_ARCH" = "i386" ]; then
	rustup target add i686-pc-windows-msvc
fi

# FIX: Download stable pkgconf directly from official MSYS2 Package Archives
curl -L "https://msys2.org" -o pkgconf.tar.zst
7z x pkgconf.tar.zst
7z x pkgconf.tar
rm pkgconf.tar*
mv mingw64 pkgconf

# FIX: Download ffmpeg dependencies from upstream BtbN repository instead of dead FWGS fork
FFMPEG_ARCHIVE=$(get_ffmpeg_archive)
curl -L "https://github.com" -o ffmpeg.zip
if [ -f ffmpeg.zip ]; then
	unzip -x ffmpeg.zip
	mv "$FFMPEG_ARCHIVE" ffmpeg
fi
