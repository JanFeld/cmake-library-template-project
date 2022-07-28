# CMake Library Project Template

This project is a simple CMake Library Project Template.
It initializes the directory structure, version.h.in, CMake-Package-Configuration files as well as the `CMakeLists.txt`.


## Contents

Rudimentary installation steps are included in the `CMakeLists.txt`

### Components:

* library (shared)
* header (public header)
* package configuration (`CMakePackageConfigHelpers`)

### Directory Structure
* src/
* include/
	* <libname>
* cmake/
	* <PROJECT_NAME>Config.cmake.in
	* version.h.in
* CMakeLists.txt
* .gitignore
* setup.sh


### Default target properties:

```cmake
VERSION ${PROJECT_VERSION}
SOVERSION ${PROJECT_VERSION_MAJOR}
CXX_STANDARD 20
CXX_STANDARD_REQUIRED ON
CXX_VISIBILITY_PRESET hidden
VISIBILITY_INLINES_HIDDEN YES
```


## Setup script

### Requirements:
 * `sed`


Note: On OSX it's required to have gsed installed to make the script work properly.
```sh
brew install gnu-sed
```

Usage:
```sh
chmod +x ./setup.sh
./setup.sh <Project Name> <library/target name>
```

Remove git-directories afterwards.

```sh
rm -rf .git
```
