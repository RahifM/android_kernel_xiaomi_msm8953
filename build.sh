make O=out ARCH=arm64 mido_defconfig

PATH="$HOME/rc/prebuilts/clang/host/linux-x86/clang-r365631c/bin:$HOME/rc/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin:$HOME/rc/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin:${PATH}" \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android- \
                      CROSS_COMPILE_ARM32=arm-linux-androideabi-
