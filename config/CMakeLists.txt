# Based and improved from SideFX's own USD plugin CMake found under "${HFS}/toolkit/usd_houdini_plugins"

cmake_minimum_required(VERSION 3.6)
project(usd_houdini_sidefx)
set(LIBRARY_NAME OP_gusd)

# The path where CMake can find the HoudiniConfig.cmake file.
list(APPEND CMAKE_PREFIX_PATH "$ENV{HFS}/toolkit/cmake")

find_package(Houdini REQUIRED)

# Contrary to SideFX own CMake script, we do want to install everything in the expected CMake or Rez install path,
# and not under "~/houdini17.5" for example.

add_library(${LIBRARY_NAME} SHARED
    ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/OBJ_usdcamera.cpp
    ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/OBJ_usdcamera.h
    ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/OP_Utils.cpp
    ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/OP_Utils.h
    ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/ROP_usdoutput.cpp
    ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/ROP_usdoutput.h
    ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/SOP_usdimport.cpp
    ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/SOP_usdimport.h
    ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/SOP_usdunpack.cpp
    ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/SOP_usdunpack.h
    ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/plugin.cpp
)

# We only build for Linux as of now.
if (DEFINED $ENV{HOUDINI_HDK_LINK_GUSD})
    target_link_libraries(${LIBRARY_NAME}
        Houdini
        ${_houdini_hfs_root}/dsolib/libgusd.so)
else ()
    target_link_libraries(${LIBRARY_NAME}
        Houdini)
endif ()

# We configure the DSO the way Houdini expects it.
houdini_configure_target(${LIBRARY_NAME}
    INSTDIR ${CMAKE_INSTALL_PREFIX}/dso)

# Help.
install(
    DIRECTORY
        ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/help
    DESTINATION
        ${CMAKE_INSTALL_PREFIX}
)

# OTL/HDA files.
install(
    FILES
        ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/ROP_usdcoalesce.otl
        ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/ROP_usdlayer.otl
        ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/ROP_usdreference.otl
        ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/SOP_camerafrustum.otl
        ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/SOP_usdbindproxy.otl
        ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/SOP_usdexportattributes.hda
        ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/SOP_usdinstanceprototypes.hda
        ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/SOP_usdretime.hda
    DESTINATION
        ${CMAKE_INSTALL_PREFIX}/otls)

# SOHO Python API.
install(
    FILES
        ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/ROP_usdcoalesce.py
        ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/ROP_usdlayer.py
        ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/ROP_usdreference.py
    DESTINATION
        ${CMAKE_INSTALL_PREFIX}/soho/python2.7)

# Python UIs.
install(
    FILES
        ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/UsdImport.pypanel
    DESTINATION
        ${CMAKE_INSTALL_PREFIX}/python_panels)

# Scripts.
install(
    FILES
        ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/obj/pixar-usdcamera.py
    DESTINATION
        ${CMAKE_INSTALL_PREFIX}/scripts/obj)

# Icons.
install(
    FILES
        ${USD_HOUDINI_SIDEFX_SOURCE_PATH}/icons/pxh_gusdIcon.png
    DESTINATION
        ${CMAKE_INSTALL_PREFIX}/config/Icons)
