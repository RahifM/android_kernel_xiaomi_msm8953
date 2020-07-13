make O=out ARCH=arm64 mido_defconfig

PATH="$HOME/android/pa/prebuilts/gcc/linux-x86/aarch64/aarch64-elf/bin:${PATH}" \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CROSS_COMPILE=aarch64-elf- \
                      2>&1 | tee buildlog.txt
