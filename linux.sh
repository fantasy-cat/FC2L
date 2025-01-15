#!/bin/bash

echo "Welcome to FC2L on Linux"
echo "Hit enter to begin"

BUILD_DIR="$PWD/fc2l/linux"
SRC_DIR="$PWD/luajit/src"
FC2_DIR="$PWD/fc2t"
CWD_DIR="$PWD"

if [ ! -d "$BUILD_DIR" ]; then
    mkdir -p "$BUILD_DIR"
fi

read -p "Press enter to continue..."

cd "$SRC_DIR"

echo "Cleaning built files & FC2L build"
find "$BUILD_DIR" -type f -exec rm -r {} \;

echo "Running make to build LuaJIT..."
make LUAJIT_ENABLE_LUA52=0 BUILD_SHARED_LIBS=OFF

cd "$CWD_DIR"

if [ ! -f "$SRC_DIR/libluajit.a" ]; then
    echo "Build failed: libluajit.a not found."
    exit 1
fi

echo "Moving build files to $BUILD_DIR..."
find "$SRC_DIR" -type f \( -iname "*.a" -o -iname "*.so" -o -iname "*.exp" -o -iname "*.exe" \) | while read -r file; do
    relative_path="${file#$SRC_DIR/}"
    mkdir -p "$BUILD_DIR/$(dirname "$relative_path")"
    cp "$file" "$BUILD_DIR/$relative_path"
done

echo "Moving header files to $BUILD_DIR..."
find "$SRC_DIR" -type f \( -iname "*.h" -o -iname "*.hpp" \) | while read -r file; do
    relative_path="${file#$SRC_DIR/}"
    mkdir -p "$BUILD_DIR/$(dirname "$relative_path")"
    cp "$file" "$BUILD_DIR/$relative_path"
done

echo "Moving fc2 header files to $BUILD_DIR..."
find "$FC2_DIR" -type f \( -iname "*.h" -o -iname "*.hpp" \) -not -path "$FC2_DIR/examples/*" | while read -r file; do
    relative_path="${file#$FC2_DIR/}"
    mkdir -p "$BUILD_DIR/$(dirname "$relative_path")"
    cp "$file" "$BUILD_DIR/$relative_path"
done

echo "Build and file organization complete!"
echo "Files are now located in $BUILD_DIR."