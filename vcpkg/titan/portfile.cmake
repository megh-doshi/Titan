# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)

include(vcpkg_common_functions)

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/Titan)

vcpkg_from_github(OUT_SOURCE_PATH SOURCE_PATH
        REPO ja3067/Titan
        REF 3aefbe382cde613
        SHA512 59505a5f616c3f69ae41d6d956c821b972468d64e7ca20de11c9dd36953bb6dbf7125b2ff81f83835ef6beb27d6753f425a9cd24e008710f453df7d8ea8cfae6
        HEAD_REF master
        )

find_program(NVCC
        NAMES nvcc nvcc.exe
        PATHS
        ENV CUDA_PATH
        ENV CUDA_BIN_PATH
        PATH_SUFFIXES bin bin64
        DOC "Toolkit location."
        NO_DEFAULT_PATH
        )

if (NVCC)
    message(STATUS "Found CUDA compiler at " ${NVCC})
else()
    message(FATAL_ERROR "CUDA compiler not found")
endif()

set(CMAKE_CUDA_COMPILER:FILEPATH ${NVCC})

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    vcpkg_configure_cmake( # may be added later
            SOURCE_PATH ${SOURCE_PATH}
            PREFER_NINJA
            OPTIONS
            -DTITAN_SHARED_BUILD=OFF
            -DCMAKE_CUDA_COMPILER:FILEPATH=${NVCC}
    )
else()
    message(STATUS "Building SHARED library")
    vcpkg_configure_cmake(
            SOURCE_PATH ${SOURCE_PATH}
            PREFER_NINJA
            OPTIONS
            -DTITAN_SHARED_BUILD=ON
            -DCMAKE_CUDA_COMPILER:FILEPATH=${NVCC}
    )
endif()

vcpkg_install_cmake()
file(
        REMOVE_RECURSE
        ${CURRENT_PACKAGES_DIR}/debug/include
        ${CURRENT_PACKAGES_DIR}/debug/share
)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/vcpkg/copyright.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/titan RENAME copyright)
