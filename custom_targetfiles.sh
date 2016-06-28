#!/bin/bash


TARGET_DIR=out/merged_target_files

echo ">>> in custom_targetfiles"

cp -f other/SuperSU.zip $TARGET_DIR/META

cd $TARGET_DIR/SYSTEM
rm -rf tts

mkdir stocksettings/KernelFile

cd ../BOOTABLE_IMAGES

unpack_bootimg boot.img newBoot
cp -f ../../../other/img_info newBoot/
pack_bootimg newBoot PrefKernel.img
rm -rf newBoot

mv PrefKernel.img ../SYSTEM/stocksettings/KernelFile
cp -f boot.img ../SYSTEM/stocksettings/KernelFile/DefKernel.img
