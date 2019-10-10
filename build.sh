#!/usr/bin/bash

# Will exit the Bash script the moment any command will itself exit with a non-zero status, thus an error.
set -e

BUILD_PATH=$1
USD_HOUDINI_SIDEFX_VERSION=${REZ_BUILD_PROJECT_VERSION}

# We print the arguments passed to the Bash script.
echo -e "\n"
echo -e "============="
echo -e "=== BUILD ==="
echo -e "============="
echo -e "\n"

echo -e "[BUILD][ARGS] BUILD PATH: ${BUILD_PATH}"
echo -e "[BUILD][ARGS] USD-HOUDINI-SIDEFX VERSION: ${USD_HOUDINI_SIDEFX_VERSION}"

# We check if the arguments variables we need are correctly set.
# If not, we abort the process.
if [[ -z ${BUILD_PATH} || -z ${USD_HOUDINI_SIDEFX_VERSION} ]]; then
    echo -e "\n"
    echo -e "[BUILD][ARGS] One or more of the argument variables are empty. Aborting..."
    echo -e "\n"

    exit 1
fi

# We build USD-Houdini-SideFX.
echo -e "\n"
echo -e "[BUILD] Building USD-Houdini-SideFX-${USD_HOUDINI_SIDEFX_VERSION}..."
echo -e "\n"

cd ${BUILD_PATH}

make \
    -j${REZ_BUILD_THREAD_COUNT}

echo -e "\n"
echo -e "[BUILD] Finished building USD-Houdini-SideFX-${USD_HOUDINI_SIDEFX_VERSION}!"
echo -e "\n"
