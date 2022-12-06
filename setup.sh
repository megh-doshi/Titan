#!/bin/bash

gtestpath="lib/googletest"
vcpkgpath="lib/vcpkg"

# setup googletest
if [ ! -d "$gtestpath" ]; then
    git clone https://github.com/google/googletest.git $gtestpath
    cd $gtestpath
    git checkout -q release-1.10.0
    cd ~- # change back to previous dir and no output to terminal
fi

sudo apt-get install -y --no-install-recommends \
    libglew-dev libglfw3-dev libglm-dev libgl-dev libgl1-mesa-dev cmake
