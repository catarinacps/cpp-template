#!/bin/bash

# This script manages remote dependencies
# ONLY SUPPORTS HEADER FILES

cd include

for par in "$@"; do
    dep=($par)

    name=${dep[0]}
    dir="$name"
    target=("${dep[@]:1}")

    if [ ! -d $dir ]; then
        echo "=> Dependency '$name' not found!"
        mkdir $dir
        cd $dir

        for url in "${target[@]}"; do
            echo "==> Downloading $(basename $url)..."
            curl -O -L $url
            echo
        done

        echo "=> Finished downloading '$name'!"
        echo
        cd ..
    fi
done

cd ..
