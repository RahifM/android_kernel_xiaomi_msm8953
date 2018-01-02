#!/bin/sh
export CROSS_COMPILE="/home/tejachaitu96/.kernel/aarch64-android/bin/aarch64-linux-android-"

export ARCH=arm64

make clean O=out/
make mrproper O=out/

make mido_defconfig O=out/

make -j4 O=out/
