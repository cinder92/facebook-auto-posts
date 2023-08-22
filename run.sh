#!/bin/sh

initialize(){
  yarn
}

run_build_runner() {
  dart run build_runner build --delete-conflicting-outputs 
}

run_build_macos() {
  rm -rf ./installers/macos/facebook_auto_posts.dmg
  yarn compile
}

run_build_windows() {
 flutter build windows
}

if [ "$1" = "init" ]; then initialize; exit $?; exit; fi
if [ "$1" = "build-runner" ]; then run_build_runner ; exit $?; fi
if [ "$1" = "lint" ]; then flutter analyze; exit $?; exit; fi
if [ "$1" = "build-macos" ]; then run_build_macos; exit $?; exit; fi
if [ "$1" = "build-windows" ]; then run_build_windows; exit $?; exit; fi


echo "Command not found"