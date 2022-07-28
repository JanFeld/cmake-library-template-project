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

${SED_EXEC} -i -E "s/@PROJECT_NAME@/$1/g" CMakeLists.txt cmake/*.cmake.in
${SED_EXEC} -i -E "s/@LIBNAME@/$2/g" CMakeLists cmake/*.cmake.in

mv cmake/PROJECT_NAMEConfig.cmake.in $1Config.cmake.in
