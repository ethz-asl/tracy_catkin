cmake_minimum_required(VERSION 3.11)
project(tracy_catkin)

find_package(catkin_simple REQUIRED)
catkin_simple()

file(MAKE_DIRECTORY ${CATKIN_DEVEL_PREFIX}/include)


include(ExternalProject)
ExternalProject_Add(
    tracy_src
    GIT_REPOSITORY https://github.com/wolfpld/tracy.git
    GIT_TAG v0.9.1
    GIT_SHALLOW TRUE
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND cd ../tracy_src &&
    cmake .
#
    -DTRACY_ENABLE:BOOL=${TRACY_ENABLE}
    -DTRACY_TIMER_FALLBACK:BOOL=${TRACY_TIMER_FALLBACK}
#    
    -DCMAKE_INSTALL_PREFIX:PATH=${CATKIN_DEVEL_PREFIX}
    -DBUILD_SHARED_LIBS:BOOL=true
    -DCMAKE_BUILD_TYPE:STRING=Release
    -DCMAKE_TOOLCHAIN_FILE:STRING=${CMAKE_TOOLCHAIN_FILE}
    BUILD_COMMAND cd ../tracy_src && make -j 8
    INSTALL_COMMAND cd ../tracy_src && make install -j 8
)

cs_export(INCLUDE_DIRS ${CATKIN_DEVEL_PREFIX}/include
    LIBRARIES TracyClient)
