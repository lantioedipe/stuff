#!/bin/bash
#by Lanti Oedipe (14.05.2014)


COCOS2DX_PATH = ""
ANDROID_NDK_PATH = "" 
ANDROID_SDK_PATH = "" 
ANT_PATH = "" 
ADB_SHELL_PATH = $ANDROID_SDK_PATH/platform-tools/adb

#project's settings 
BUILD_PATH = "" 
RESOURCE_PATH = "" 
PACKAGE_PATH = "" 
PROJECT_NAME = "" 

#paste from copy_resources.sh  
GAME_ROOT_PATH = "" 
GAME_ANDROID_ROOT_PATH = ""   #it looks like $GAME_ROOT_PATH/proj.android 
RESOURCES_ROOT_PATH = $GAME_ROOT_PATH/Resources

if [ -d $GAME_ANDROID_ROOT_PATH/assets ]; then
    rm -rf $GAME_ANDROID_ROOT_PATH/assets
fi

mkdir $GAME_ANDROID_ROOT_PATH/assets

#there is a moment of copying actually
for file in $RESOURCE_ROOT_PATH/*
do
    if [ -d $file ]; then
        cp -rf $file $GAME_ANDROID_ROOT_PATH/assets
    fi

    if [ -f $file ]; then
        cp $file $GAME_ANDROID_ROOT_PATH/assets
    fi
done

#second step: android's manager 
$ANDROID_SDK_PATH/tools/android update project -path $BUILD_PATH --target android-19 

#third step: ndk-build
$ANDROID_NDK_PATH/ndk-build NDK_MODULE_PATH=  NDK_PROJECT_PATH=

#paste from run.sh
$ADB_SHELL_PATH/adb shell exit 
$ADB_SHELL_PATH/adb shell am start -a android.intent.action.MAIN -n $PACKAGE_PATH/$PACKAGE_PATH.$PROJECT_NAME

$ADB_SHELL_PATH/adb shell logcat

echo "done" 
