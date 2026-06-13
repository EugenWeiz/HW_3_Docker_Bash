#!/bin/bash

if [ "$1" = "build_generator" ]; then
  docker build -t student-data-generator ./generator

elif [ "$1" = "run_generator" ]; then
  mkdir -p data
  docker run --rm -v "$(pwd)/data:/data" student-data-generator

elif [ "$1" = "create_local_data" ]; then
  mkdir -p local_data
  python3 generator/generate.py local_data

elif [ "$1" = "build_reporter" ]; then
  docker build -t student-data-reporter ./reporter

elif [ "$1" = "run_reporter" ]; then
  mkdir -p data
  docker run --rm -v "$(pwd)/data:/data" student-data-reporter

else
  echo "Неизвестная команда"
  echo "Доступные команды:"
  echo "./run.sh build_generator"
  echo "./run.sh run_generator"
  echo "./run.sh create_local_data"
  echo "./run.sh build_reporter"
  echo "./run.sh run_reporter"
fi