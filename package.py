name = "usd_houdini_sidefx"

version = "17.5.360"

authors = [
    "Pixar",
    "SideFX"
]

description = \
    """
    USD plugin for SideFX Houdini, using the builtin USD libraries and binaries and plugin sources from Houdini
    itself, and not the ones from the Pixar GitHub repository.
    """

requires = [
    "cmake-3+",
    "gcc-6+",
    "houdini-17.5.360",
]

variants = [
    ["platform-linux"]
]

build_system = "cmake"

with scope("config") as config:
    config.build_thread_count = "logical_cores"

uuid = "usd_houdini_sidefx-{version}".format(version=str(version))

def commands():
    env.HOUDINI_PATH.append("{root}")

    # Helper environment variables.
    env.USD_HOUDINI_SIDEFX_LIBRARY_PATH.set("{root}/dso")
