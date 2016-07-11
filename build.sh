#!/bin/bash
#
#Flyme auto make script

buildDir=/home/leon/Android/Flyme/build
pwd=$PWD

function initEnv() {
    echo ">>> 初始化编译环境"
    source ../../build/envsetup.sh
    cd $pwd
}

function makeFull() {
    echo ">>> 编译全量包"
    flyme cleanall
    flyme fullota
	
    if [ -e out/flyme*.zip ];then
        cd out
		
        beforeName=$(basename flyme*.zip)
        versionName=${beforeName##*_}
		
        mv flyme*.zip Flyme_A0001_Leon_$versionName
        mv target*.zip target_files.zip
		
        echo "<<< 全量包编译完成"
    else
        echo "<<< 全量包编译失败"
    fi

    cd ..
}

function makeOTA() {
    echo "是否编译OTA包？(Y/n)"
		
    read keyboard
    case $keyboard in
        Y|y|YES|yes)
        echo ">>> 编译OTA包"
		
        ../../build/tools/releasetools/ota_from_target_files -k ../../build/security/testkey -i history_package/last_target_files.zip out/target_files.zip out/OTA_Flyme_A0001_$versionName
        cleanCache

        echo "<<< OTA包编译完成"
    esac	
}

function cleanCache(){
    echo ">>> 清除缓存文件"

    if [ -e out/Flyme*.zip ];then
        rm -rf history_package
        mkdir history_package
        mkdir Flyme_Done

        mv out/target_files.zip history_package
        mv out/Flyme*.zip Flyme_Complete
        mv out/OTA*.zip Flyme_Complete

        mv history_package/target_files.zip history_package/last_target_files.zip
    fi

    flyme cleanall
}

function printUseTime() {
    let "okTime=$endTime-$startTime"
    let "okH=$okTime/60"
    let "okMin=$okTime%60"
	
    echo "<<< 完成"
    echo "<<< 耗时$okH分$okMin秒"
}

startTime=`date +%s`
initEnv
makeFull
makeOTA
endTime=`date +%s`
printUseTime
