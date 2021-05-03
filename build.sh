#!/bin/bash
#
# Copyright (C) 2017 Ashish Malik (im.ashish994@gmail.com)
# Copyright (C) 2018 Rahif M (faizel326@gmail.com)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

#colors
red='\033[0;31m'
green='\033[0;32m'
brown='\033[0;33m'
blue='\033[0;34m'
purple='\033[1;35m'
cyan='\033[0;36m'
nc='\033[0m'

#directories
KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb
ZIP_DIR=$KERNEL_DIR/AnyKernel2
CONFIG_DIR=$KERNEL_DIR/arch/arm64/configs
TELEGRAM=$HOME/telegram.sh/telegram
ZIP=$KERNEL_DIR/AnyKernel2/*.zip
LOG=$KERNEL_DIR/buildlog*.txt

#export
export CROSS_COMPILE="$HOME/android/arm64-gcc/bin/aarch64-elf-"
#export CROSS_COMPILE="$HOME/android/pa/prebuilts/gcc/linux-x86/aarch64/aarch64-elf/bin/aarch64-elf-"
export ARCH=arm64
export SUBARCH=arm64

#misc
CONFIG=mido_defconfig
THREAD="-j$(grep -c ^processor /proc/cpuinfo)"

#main script
while true; do
echo -e "\n$green[1]Build kernel"
echo -e "[2]Regenerate defconfig"
echo -e "[3]Source cleanup"
echo -e "[4]Generate flashable zip"
echo -e "[5]Upload zip"
echo -e "[6]Upload buildlog"
echo -e "[7]Quit$nc"
echo -ne "\n$blue(i)Please enter a choice[1-7]:$nc "

read choice

if [ "$choice" == "1" ]; then
  BUILD_START=$(date +"%s")
  DATE=`date`
  echo -e "\n$cyan#######################################################################$nc"
  echo -e "$brown(i)Build started at $DATE$nc"
  make $CONFIG $THREAD O=out/
  make $THREAD O=out/ 2>&1 | tee buildlog.txt
  spin[0]="$blue-"
  spin[1]="\\"
  spin[2]="|"
  spin[3]="/$nc"

  echo -ne "$blue[...] ${spin[0]}$nc"
  while kill -0 $pid &>/dev/null
  do
    for i in "${spin[@]}"
    do
          echo -ne "\b$i"
          sleep 0.1
    done
  done
  if ! [ -a $KERN_IMG ]; then # FIXME: On dirty builds this returns as success
    echo -e "\n$red(!)Kernel compilation failed.$nc"
    echo -e "$red#######################################################################$nc"
    exit 1
  fi
  BUILD_END=$(date +"%s")
  DIFF=$(($BUILD_END - $BUILD_START))
  echo -e "\n$brown(i)Kernel compiled successfully.$nc"
  echo -e "$cyan#######################################################################$nc"
  echo -e "$purple(i)Total time elapsed: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nc"
  echo -e "$cyan#######################################################################$nc"
fi


if [ "$choice" == "2" ]; then
  echo -e "\n$cyan#######################################################################$nc"
  make $CONFIG
  cp .config arch/arm64/configs/$CONFIG
  echo -e "$purple(i)Defconfig generated.$nc"
  echo -e "$cyan#######################################################################$nc"
fi


if [ "$choice" == "3" ]; then
  echo -e "\n$cyan#######################################################################$nc"
  rm -f $KERN_IMG
  make clean
  make mrproper
  make clean O=out/
  make mrproper O=out/
  echo -e "$purple(i)Kernel source cleaned up.$nc"
  echo -e "$cyan#######################################################################$nc"
fi


if [ "$choice" == "4" ]; then
  echo -e "\n$cyan#######################################################################$nc"
  cd $ZIP_DIR
  make clean &>/dev/null
  cp $KERN_IMG $ZIP_DIR
  make &>/dev/null
  cd ..
  echo -e "$purple(i)Flashable zip generated under $ZIP_DIR.$nc"
  echo -e "$cyan#######################################################################$nc"
fi

if [ "$choice" == "5" ]; then
  cd $ZIP_DIR
  $TELEGRAM -f $ZIP
  cd ..
fi

if [ "$choice" == "6" ]; then
  $TELEGRAM -f $LOG
fi

if [ "$choice" == "7" ]; then
 exit 1
fi
done
