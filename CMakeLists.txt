CMAKE_MINIMUM_REQUIRED(VERSION 3.0)

include(RezBuild)
include(RezRepository)
include(ExternalProject)

# The environment variable REZ_TMP_PATH is meant to point to a location such as "/tmp/rez".
set(BUILD_DIR $ENV{REZ_TMP_PATH}/usd_houdini_sidefx/${REZ_BUILD_PROJECT_VERSION})

# We execute the configure Bash script.
execute_process(
    COMMAND
    bash ${CMAKE_SOURCE_DIR}/configure.sh ${BUILD_DIR}
    RESULT_VARIABLE RETURN_CODE_CONFIGURE
)

# We execute the build Bash script.
execute_process(
    COMMAND
    bash ${CMAKE_SOURCE_DIR}/build.sh ${BUILD_DIR}
    RESULT_VARIABLE RETURN_CODE_BUILD
)

# We execute the install Bash script.
execute_process(
    COMMAND
    bash ${CMAKE_SOURCE_DIR}/install.sh ${BUILD_DIR}
    RESULT_VARIABLE RETURN_CODE_INSTALL
)

# We check that the execute_process() macros terminated properly.
# If not, we abort the process.
if (RETURN_CODE_CONFIGURE EQUAL "1")
    message(FATAL_ERROR "[CMAKE] Configure script returned an error code. Aborting...")
elseif (RETURN_CODE_BUILD EQUAL "1")
    message(FATAL_ERROR "[CMAKE] Build script returned an error code. Aborting...")
elseif (RETURN_CODE_INSTALL EQUAL "1")
    message(FATAL_ERROR "[CMAKE] Install script returned an error code. Aborting...")
endif()

# We use a bogus CMake "install" step in order to be able to properly finish
# and get out of the CMake script.
install(
    CODE
    "execute_process(
        COMMAND echo \"\n[CMAKE] USD-Houdini-SideFX-${REZ_BUILD_PROJECT_VERSION} PACKAGE SETUP FINISHED!\n\"
    )"
)
