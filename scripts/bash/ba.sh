MATS=("RenderChunk" "Clouds" "Sky" "LegacyCubemap" "SunMoon")

#for mat in "${MATS[@]}"; do
#        echo "building $mat for main pack..."
#        lazurite build ./proj -o out/platform/android/pack/renderer/materials/ -p android -m $mat --shaderc env/shaderc 
#        sleep 0.2
#	echo " "
#done

lazurite build ./proj -p android --shaderc env/shaderc
