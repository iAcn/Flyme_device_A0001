#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 11112448 d8036f1b3c575264680d25465cdfe6342e658a0b 8361984 ce83d2f6c670b1df1f7458bfedc41eec2d8fe065
fi

if ! applypatch -c EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery:11112448:d8036f1b3c575264680d25465cdfe6342e658a0b; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/msm_sdcc.1/by-name/boot:8361984:ce83d2f6c670b1df1f7458bfedc41eec2d8fe065 EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery d8036f1b3c575264680d25465cdfe6342e658a0b 11112448 ce83d2f6c670b1df1f7458bfedc41eec2d8fe065:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
