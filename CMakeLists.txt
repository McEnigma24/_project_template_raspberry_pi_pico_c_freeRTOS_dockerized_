cmake_minimum_required(VERSION 3.18)

set(PICO_SDK_PATH "${CMAKE_SOURCE_DIR}/external/pico-sdk")
include(pico_sdk_import.cmake)

project(MyProject LANGUAGES CXX C ASM)

pico_sdk_init()
set(ALL_LIBRARIES ${ALL_LIBRARIES} pico_stdlib)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED True)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# MACRO FOR LOGS # - dont show the whole realpath to file

string(LENGTH "${CMAKE_SOURCE_DIR}/" SOURCE_PATH_SIZE)
add_definitions(-DSOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

set(CONST_TARGET_NAME "rasp_target.exe")



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

include_directories(_inc)
aux_source_directory(_src SOURCES)



    message(WARNING "Building exe")
    set(TARGET_NAME "${CONST_TARGET_NAME}")
    add_executable(${TARGET_NAME} ${SOURCES})

    target_compile_definitions(${TARGET_NAME} PRIVATE PICO)
    target_link_libraries(${TARGET_NAME} PUBLIC ${ALL_LIBRARIES})

    pico_add_extra_outputs(${TARGET_NAME})

