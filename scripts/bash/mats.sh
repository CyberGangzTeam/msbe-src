#!/bin/bash

MATERIALS=""
PLATFORM="android"
SUBPACK_BUILD=""

while getopts ":m:p:s:" opt; do
  case $opt in
    m)
      MATERIALS="$OPTARG"
      ;;
    p)
      PLATFORM="$OPTARG"
      ;;
    s)
      SUBPACK_BUILD="$OPTARG"
      ;;
    \?)
      echo "Error: unkown option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      
      echo "Error: Options -$OPTARG need an argument." >&2
      exit 1
      ;;
  esac
done

COMMAND="lazurite build ./proj"


if [ -n "$MATERIALS" ]; then
    COMMAND="$COMMAND -m $MATERIALS"
fi

COMMAND="$COMMAND -p $PLATFORM"

echo "Command will be execute: $COMMAND"

COMMAND="$COMMAND --shaderc env/shaderc"

echo "---------- Make materials dir for $PLATFORM ----------"
echo "creating subpacks pack dir..."
mkdir -p out/platform/$PLATFORM/materials
sleep 0.1

if [ -n "$SUBPACK_BUILD" ]; then
  echo "copy subpack $SUBPACK_BUILD config to global config..."
  cat include/configs/subpacks/$SUBPACK_BUILD/config.cfg >> global_config/.config
  sleep 0.2
else
  echo "copy main config to global config..."
  cat include/configs/main/config.cfg >> global_config/.config
  sleep 0.2
fi

echo "Building material for $PLATFORM..."
$COMMAND
sleep 0.1
mv *.material.bin out/platform/$PLATFORM/materials/
sleep 0.1

echo "remove global config..."
rm -f global_config/.config
sleep 0.3

echo "Done"