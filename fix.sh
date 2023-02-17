#!/usr/bin/env bash
 
if [[ ! -f "dice-mac.zip" ]] ;
then
  echo "Missing file dice-mac.zip."
  echo "Copy the dice-mac.zip file to ${PWD} and re-run this script."
  exit 1
fi
 
 
if [[ ! -f "lwjgl.zip" ]] ;
then
  wget https://github.com/LWJGL/lwjgl3/releases/download/3.3.1/lwjgl.zip
fi
mkdir -p lwjgl
unzip -jnd ./lwjgl/ lwjgl.zip lwjgl/lwjgl-natives-linux.jar lwjgl-glfw/lwjgl-glfw-natives-linux.jar lwjgl-jemalloc/lwjgl-jemalloc-natives-linux.jar lwjgl-openal/lwjgl-openal-natives-linux.jar lwjgl-opengl/lwjgl-opengl-natives-linux.jar lwjgl-stb/lwjgl-stb-natives-linux.jar
find lwjgl/ -exec unzip -nd ./modtemp {} \;
rm -rf modtemp/META-INF/
 
 
if [[ ! -f "natives.zip" ]] ;
then
  wget https://libgdx-nightlies.s3.eu-central-1.amazonaws.com/libgdx-nightlies/natives.zip
fi
unzip -jnd ./modtemp/ natives.zip extensions/gdx-bullet/libs/linux64/libgdx-bullet64.so gdx/libs/linux64/libgdx64.so -n -d ./modtemp/
 
 
unzip -j dice-mac.zip SliceAndDice.app/Contents/Resources/dice-linux.jar
jar uvf dice.jar -C ./modtemp .
 
 
cat << EOF > ./run.sh
#/usr/bin/env bash
 
java -Dorg.lwjgl.util.Debug=true -Xmx1g -jar dice-linux.jar
EOF
 
chmod +x run-sh
 
echo "All done."
echo "Launch the game by executing run.sh"
