#!/bin/bash

if [ -d "include/configs/subpacks/" ] && find "include/configs/subpacks/" -mindepth 1 -print -quit 2>/dev/null | grep -q .; then
    ls include/configs/subpacks/
else
    echo "this shader doesn't have subpack"
fi