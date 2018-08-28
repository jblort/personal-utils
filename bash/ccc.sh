#!/bin/sh

ensure_file_present() {
    FILENAME="$1"
    FILEPATH="$2"
    FILECOUNT="$(find $2 -maxdepth 1 -type f -name "$1" | wc -l)"
    FILECOUNT="$(echo "${FILECOUNT}" | tr -d '[:space:]')"
    if [ "${FILECOUNT}" != "1" ]; then
        echo "There must be exactly one ${FILENAME} at the path provided (${FILEPATH})"
        exit 1
    fi

}

ensure_cmakelists_present() {
    ensure_file_present "CMakeLists.txt" "$1"
}

ensure_conanfile_present() {
    ensure_file_present "conanfile.txt" "$1"
}

#Use default path for invocation, parent folder
CONFIG_FILES_PATH=".."
if [ ! -z $1 ]; then
    if [ -d $1 ]; then
        CONFIG_FILES_PATH=$1 # If a valid path was specified, use it instead
    elif [ -f $1 ]; then
        echo "Please provide a path pointing to a folder"
    else
        echo "Path is invalid, please specify a valid path"
        exit 1
    fi
fi

ensure_cmakelists_present ${CONFIG_FILES_PATH}
ensure_conanfile_present ${CONFIG_FILES_PATH}

conan install ${CONFIG_FILES_PATH}

if [ $? -ne "0" ]; then
    echo "Conanfile expected to be next to the CMakeLists.txt. Aborting."
    exit 1
fi

cmake ${CONFIG_FILES_PATH}

cmake --build .


