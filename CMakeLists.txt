cmake_minimum_required(VERSION 3.23)

project(@PROJECT_NAME@ VERSION 0.1.0 LANGUAGES CXX C)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

################################################################################
# Options
################################################################################

################################################################################
# Directories/Files
################################################################################

set(@PROJECT_NAME@_SOURCES
	src/@LIBNAME@.cc
)

set(@PROJECT_NAME@_HEADER
)

set(@PROJECT_NAME@_PUBLIC_HEADER
)

configure_file(cmake/version.h.in ${CMAKE_CURRENT_LIST_DIR}/src/version.h)

################################################################################
# Target setup
################################################################################

add_library(@LIBNAME@ SHARED)
set_target_properties(@LIBNAME@
	PROPERTIES
	VERSION	${PROJECT_VERSION}
	SOVERSION ${PROJECT_VERSION_MAJOR}
	CXX_STANDARD 20
	CXX_STANDARD_REQUIRED ON
	CXX_VISIBILITY_PRESET hidden
	VISIBILITY_INLINES_HIDDEN YES
)

target_compile_options(@LIBNAME@
	PRIVATE
	-Wall
	-Wextra
	-Werror
)

target_include_directories(@LIBNAME@
	PRIVATE
		${CMAKE_CURRENT_LIST_DIR}/src/
		${CMAKE_CURRENT_LIST_DIR}/include/@LIBNAME@

	PUBLIC
		${CMAKE_CURRENT_LIST_DIR}/include/
)

target_sources(@LIBNAME@
	PRIVATE
		${@PROJECT_NAME@_SOURCES}

	PUBLIC
		${@PROJECT_NAME@_PUBLIC_HEADER}
)

################################################################################
# Install
################################################################################

set(@PROJECT_NAME@_INCLUDE_DIRS ${CMAKE_INSTALL_INCLUDEDIR})
set(@PROJECT_NAME@_LIBRARIES @LIBNAME@)

write_basic_package_version_file(
	${CMAKE_CURRENT_BINARY_DIR}/@PROJECT_NAME@ConfigVersion.cmake
	VERSION ${PROJECT_VERSION}
	COMPATIBILITY SameMajorVersion
)

configure_package_config_file(cmake/@PROJECT_NAME@Config.cmake.in
	${CMAKE_CURRENT_BINARY_DIR}/@PROJECT_NAME@Config.cmake
	INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/@PROJECT_NAME@/cmake
	PATH_VARS
		@PROJECT_NAME@_INCLUDE_DIRS
		@PROJECT_NAME@_LIBRARIES
)

install(TARGETS @LIBNAME@
	RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
	LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
	ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
	INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
	PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/@LIBNAME@
	COMPONENT library
)

install(FILES
	${@PROJECT_NAME@_PUBLIC_HEADER}
	DESTINATION
		${CMAKE_INSTALL_INCLUDEDIR}/@LIBNAME@
	COMPONENT header
)

install(FILES
	${CMAKE_CURRENT_BINARY_DIR}/@PROJECT_NAME@Config.cmake
	${CMAKE_CURRENT_BINARY_DIR}/@PROJECT_NAME@ConfigVersion.cmake
	DESTINATION
		${CMAKE_INSTALL_LIBDIR}/@PROJECT_NAME@/cmake
	COMPONENT package
)


