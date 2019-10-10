#!/usr/bin/bash

# Will exit the Bash script the moment any command will itself exit with a non-zero status, thus an error.
set -e

BUILD_PATH=$1
INSTALL_PATH=${REZ_BUILD_INSTALL_PATH}
USD_HOUDINI_SIDEFX_VERSION=${REZ_BUILD_PROJECT_VERSION}

# We print the arguments passed to the Bash script.
echo -e "\n"
echo -e "================="
echo -e "=== CONFIGURE ==="
echo -e "================="
echo -e "\n"

echo -e "[CONFIGURE][ARGS] BUILD PATH: ${BUILD_PATH}"
echo -e "[CONFIGURE][ARGS] INSTALL PATH: ${INSTALL_PATH}"
echo -e "[CONFIGURE][ARGS] USD-HOUDINI-SIDEFX VERSION: ${USD_HOUDINI_SIDEFX_VERSION}"

# We check if the arguments variables we need are correctly set.
# If not, we abort the process.
if [[ -z ${BUILD_PATH} || -z ${INSTALL_PATH} || -z ${USD_HOUDINI_SIDEFX_VERSION} ]]; then
    echo -e "\n"
    echo -e "[CONFIGURE][ARGS] One or more of the argument variables are empty. Aborting..."
    echo -e "\n"

    exit 1
fi

# We run the configuration script of USD-Houdini-SideFX.
echo -e "\n"
echo -e "[CONFIGURE] Running the configuration script from USD-Houdini-SideFX-${USD_HOUDINI_SIDEFX_VERSION}..."
echo -e "\n"

mkdir -p ${BUILD_PATH}
cd ${BUILD_PATH}

cp ${REZ_BUILD_SOURCE_PATH}/config/CMakeLists.txt ${BUILD_PATH}/CMakeLists.txt

# We manually had the compilers flags for OpenGL related libraries as it can happen that on too fresh CentOS images,
# the LD_LIBRARY_PATH environment variable is not even setup properly with the bare minimum paths.
cmake \
    ${BUILD_PATH} \
    -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DUSD_HOUDINI_SIDEFX_SOURCE_PATH=${REZ_HOUDINI_ROOT}/toolkit/usd_houdini_plugins

echo -e "\n"
echo -e "[CONFIGURE] Finished configuring USD-Houdini-SideFX-${USD_HOUDINI_SIDEFX_VERSION}!"
echo -e "\n"
