#!/bin/bash

MATS=("RenderChunk" "Clouds" "Sky" "LegacyCubemap" "SunMoon")

while [[ $# -gt 0 ]]; do
    key="$1"
    
    case "$key" in
        --pack)
            PLATFORM="$2"
            if [ "$PLATFORM" == "android" ]; then
                echo " "
                echo "---------- Make pack assets for $PLATFORM ----------"
                echo "removing out old build file..."
                rm -rf out/platform/android
                sleep 0.5
                echo "creating out pack dir..."
                mkdir -p out/platform/android/pack
                sleep 0.1
                echo "copy pack assets to out pack dir..."
                cp -r assets/main/* out/platform/android/pack/
                sleep 0.6

                echo " "
                echo "---------- Make subpacks assets for $PLATFORM ----------"
                echo "creating subpacks pack dir..."
                mkdir -p out/platform/android/pack/subpacks
                sleep 0.1
                echo "copy subpacks assets to out subpacks dir..."
                cp -r assets/subpacks/* out/platform/android/pack/subpacks/
                sleep 0.6

                echo " "
                echo "---------- Building pack materials for $PLATFORM ----------"
                echo "copy main config to global config..."
                # cp include/configs/main/config.cfg global_config/.config
                cat include/configs/main/config.cfg >> global_config/.config
                sleep 0.1
                # for mat in "${MATS[@]}"; do
                #     echo "building $mat for main pack..."
                #     lazurite build ./proj -o out/platform/android/pack/renderer/materials/ -p android -m $mat --shaderc env/shaderc 
                #     sleep 0.2
                #     echo " "
                # done
                lazurite build ./proj -o out/platform/android/pack/renderer/materials/ -p android -m RenderChunk --shaderc env/shaderc
                echo "remove global config..."
                rm -f global_config/.config
                sleep 0.3

                for SUBPACK_CONFIG_DIR in include/configs/subpacks/*; do
                    SUBPACK_NAME=$(basename "$SUBPACK_CONFIG_DIR")
                    echo " "
                    echo "---------- Building subpack $SUBPACK_NAME materials for $PLATFORM ----------"
                    echo "copy subpack $SUBPACK_NAME config to global config..."
                    # cp include/configs/subpacks/$SUBPACK_NAME/config.cfg global_config/.config
                    # cat include/configs/subpacks/$SUBPACK_NAME/config.cfg >> global_config/.config
                    sleep 0.1

                    source include/configs/subpacks/$SUBPACK_NAME/subpack.cfg
                    MATS_FOR_SUBPACK=($SUBPACK_MATERIALS)
                    for mat in "${MATS_FOR_SUBPACK[@]}"; do
                        echo "building $mat for subpack $SUBPACK_NAME..."
                        lazurite build ./proj -o out/platform/android/pack/subpacks/$SUBPACK_NAME/renderer/materials/ -p android -m $mat --shaderc env/shaderc
                        sleep 0.2
                    done
                    echo "remove global config..."
                    rm -f global_config/.config
                done

            fi

            shift
            shift
            ;;
        esac
done