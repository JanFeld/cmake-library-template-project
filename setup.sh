#!/bin/bash

if [ -z "$1" ];
then
	echo -e "Invalid project name."
	exit
fi

if [ -z "$2" ];
then
	echo -e "Invalid library name."
	exit
fi

SED_EXEC=$(which sed)

if [[ "$OSTYPE" == "darwin"* ]];
then
	SED_EXEC=$(which gsed)
fi

PROJECT_NAME_UPPER=$(echo "$1" | ${SED_EXEC} -E "s/(.*)/\\U\\1/g")

${SED_EXEC} -i -E "s/@PROJECT_NAME@/$1/g" CMakeLists.txt cmake/*.cmake.in 
${SED_EXEC} -i -E "s/@PROJECT_NAME@/${PROJECT_NAME_UPPER}/g" cmake/version.h.in
${SED_EXEC} -i -E "s/@LIBNAME@/$2/g" CMakeLists.txt cmake/*.cmake.in

mv cmake/PROJECT_NAMEConfig.cmake.in cmake/$1Config.cmake.in
mkdir -p "include/$2"
mkdir -p src/
touch src/$2.cc
