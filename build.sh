#!/bin/sh

declare -r BASE_DIR=`dirname $0`
declare -r OUT_DIR=$BASE_DIR/out
declare -r ASSETS_DIR=images

# ================
# Helper functions
# ================

function convert()
{
    # echo -e "\t$@"

    local src_file=$@

    # asciidoctor --trace -v                     \
    asciidoctor                                  \
            -d book                              \
            -b html5                             \
            -a stylesheet=stylesheets/asciidoctor.css \
            -a linkcss!                          \
            -a icons=font                        \
            -a source-highlighter=highlightjs    \
            -a toc                               \
            -a toc2                              \
            -a toclevels=3                       \
            -a toc=right                         \
            -a idprefix!                         \
            -a idseparator=-                     \
            -a sectanchors                       \
            --compact                            \
            -D $OUT_DIR                          \
            $src_file
}

function makeDir()
{
    local target_dir=$1

    # create output dir if it doesn't exist
    if [ ! -d "$target_dir" ]; then
        mkdir -p $target_dir
    fi
}

# ===================
# Main flow execution
# ===================

# set -ex

if [ "$1" = "html" ]; then
    echo Building book...

    makeDir $OUT_DIR

    # list all asciidoc files in the DOCS_DIR
    adoc_files=(./Chapter_1.adoc ./Chapter_2.adoc ./Chapter_3.adoc ./Chapter_4.adoc ./Chapter_5.adoc ./Chapter_6.adoc  ./Chapter_7.adoc ./Chapter_8.adoc ./Chapter_9.adoc ./Chapter_10.adoc ./Chapter_11.adoc)

    convert `printf "%s " "${adoc_files[@]}" | cut -d " " -f 1-${#adoc_files[@]}`

    asciidoctor -d book -b html5 -a stylesheet=stylesheets/asciidoctor.css --out-file out/index.html toc.adoc

elif [ "$1" = "clean" ]; then
    echo Cleaning files:
    rm -rv $OUT_DIR
fi

echo -e "BUILD FINISHED"