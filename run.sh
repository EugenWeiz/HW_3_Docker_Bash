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

elif [ "$1" = "structure" ]; then
  if command -v tree > /dev/null; then
    tree -a -I '.git'
  else
    find .
  fi

elif [ "$1" = "clear_data" ]; then
  mkdir -p data
  rm -f data/*.csv
  rm -f data/*.html

elif [ "$1" = "inside_generator" ]; then
  mkdir -p data
  docker run --rm -v "$(pwd)/data:/data" --entrypoint ls student-data-generator -la /data

elif [ "$1" = "inside_reporter" ]; then
  mkdir -p data
  docker run --rm -v "$(pwd)/data:/data" --entrypoint ls student-data-reporter -la /data

elif [ "$1" = "report_server" ]; then
  if [ ! -f data/report.html ]; then
    echo "Файл data/report.html не найден"
    exit 1
  fi

  docker run -d --rm --name student-report-server -p 1984:80 -v "$(pwd)/data:/usr/share/nginx/html" nginx
  echo "Веб-сервер запущен"
  echo "Откройте порт 1984 во вкладке PORTS в GitHub Codespaces"
  echo "Затем откройте страницу report.html"

else
  echo "Неизвестная команда"
  echo "Доступные команды:"
  echo "./run.sh build_generator"
  echo "./run.sh run_generator"
  echo "./run.sh create_local_data"
  echo "./run.sh build_reporter"
  echo "./run.sh run_reporter"
  echo "./run.sh structure"
  echo "./run.sh clear_data"
  echo "./run.sh inside_generator"
  echo "./run.sh inside_reporter"
  echo "./run.sh report_server"
fi