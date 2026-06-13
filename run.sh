#!/bin/bash

if [ "$1" = "build_generator" ]; then
    docker build -t student-data-generator ./generator

elif [ "$1" = "run_generator" ]; then
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" student-data-generator

elif [ "$1" = "create_local_data" ]; then
    mkdir -p local_data
    python3 generator/generate.py local_data

else
    echo "Неизвестная команда"
    echo "Доступные команды:"
    echo "./run.sh build_generator"
    echo "./run.sh run_generator"
    echo "./run.sh create_local_data"
fi