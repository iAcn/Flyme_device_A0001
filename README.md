##Fyme PatchRom base Leon
基于CM12.1-YOG7D版本制作，会跟随CM12.1以及Flyme进行同步更新

###使用方法：
1. 下载

使用 **git clone** 命令，第一次下载时先 **cd** 到 *devices* 目录，输入：
```
git clone https://github.com/Leon0301/Flyme_device_A0001.git
```
下载完成后对其重命名为 *base_leon*， **cd** 到 *devices* 目录，输入：
```
mv ./Flyme_device_A0001 ./base_leon
```
2. 使用

在你机型目录下的 *Makefile* 文件中配置
>BASE := base_leon

>board_modify_apps := TeleService SystemUI

将 *TeleService SystemUI* 目录复制到你的机型目录中

复制完成后，即可使用 **flyme patchall** 命令来进行插桩
