make O=out ARCH=arm64 mido_defconfig

PATH="$HOME/android/aosp10/prebuilts/clang/host/linux-x86/clang-r353983c/bin:$HOME/android/aosp10/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin:$HOME/android/aosp10/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin:${PATH}" \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android- \
                      CROSS_COMPILE_ARM32=arm-linux-androideabi-
