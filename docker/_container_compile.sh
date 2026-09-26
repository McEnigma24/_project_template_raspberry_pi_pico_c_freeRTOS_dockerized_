#!/bin/bash

clear

source config

var_start=""
var_end=""
function timer_start() { var_start=$(date +%s); }
function timer_end() { var_end=$(date +%s); }
timer_print()
{
    elapsed=$((var_end - var_start))
    hours=$((elapsed / 3600))
    minutes=$(( (elapsed % 3600) / 60 ))
    seconds=$((elapsed % 60))
    printf "\nProgram          - took: %02d:%02d:%02d\n" $hours $minutes $seconds
}
function env_prep()
{
    create_dir "$DIR_INPUT"
    create_dir "$DIR_BUILD"
    create_dir "$DIR_TARGET"
    create_dir "$DIR_EXTERNAL"
    create_dir "$DIR_LOG"
    create_dir "$DIR_OUTPUT"
    create_dir "$DIR_RUN_TIME_CONFIG"

    chmod +x scripts/*.sh
    chmod +x docker/*.sh

    while getopts "c" opt; do
    case "$opt" in
        c)
            clear_dir "$DIR_BUILD"
        ;;
        \?)
        echo "Error: $0 getopts switch -$OPTARG" >&2
        exit 1
        ;;
    esac
    done

    shift $((OPTIND -1))
}

#####################   START   #####################

env_prep "$@"

timer_start
{
    cd scripts || exit 1
    ./production.sh 2>&1 | tee "$LOG_container_compile"
    compilation_status=$?
}
timer_end

timer_print

exit $compilation_status
