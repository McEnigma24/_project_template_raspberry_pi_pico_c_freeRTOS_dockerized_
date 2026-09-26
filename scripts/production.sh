#!/bin/bash

source ../config

EXE="*.exe*"

function clean_env()
{
    cd $DIR_ROOT
    echo -e "\nBuild (1/2) - Cleaning env"
    clear_dir "$DIR_TARGET"
    clear_dir "$DIR_OUTPUT"
    # clear_dir "$DIR_LOG"
    if ls $DIR_BUILD/$EXE 1> /dev/null 2>&1; then
        rm -f $DIR_BUILD/$EXE
    fi
}

function build_all()
{
    cd $DIR_ROOT
    echo -e "\nBuild (2/2) - Building"

    cmake -S . -B $DIR_BUILD
    cmake --build $DIR_BUILD

    if [ $? -eq 0 ]; then
        echo ""
    else
        echo -e "\nproduction.sh - ERROR - unable to BUILD\n"
        exit 1
    fi
}

function copy_firmware()
{
    cd $DIR_ROOT
    echo -ne "\nCopying firmware to exe"

    if ls $DIR_BUILD/$EXE 1> /dev/null 2>&1; then
        echo -e " ✅\n"
        cp $DIR_BUILD/$EXE $DIR_TARGET/
    else
        echo -e " ❌\n"
        echo -e "\nproduction.sh - ERROR - no firmware outputs in $DIR_BUILD/\n"
        exit 1
    fi
}

# START #

clean_env

build_all

copy_firmware
