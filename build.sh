make O=out ARCH=arm64 mido_defconfig

PATH="$HOME/android/aosp10/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin:${PATH}" \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CROSS_COMPILE=aarch64-linux-android-
