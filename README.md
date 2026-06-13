# HW_3_Docker_Bash

Выполнение третьего домашнего задание в рамках курса Технологии программирования.

## Описание проекта

Проект генерирует CSV-файл с учебными показателями студентов, а затем создаёт на его основе HTML-отчёт.
В проекте используются три Docker-контейнера:

* `student-data-generator` — создаёт файл `data/data.csv`;
* `student-data-reporter` — анализирует CSV-файл и создаёт `data/report.html`;
* `student-report-server` — запускает веб-сервер nginx и позволяет открыть HTML-отчёт в браузере.

## Запуск проекта

Сборка и запуск генератора данных:

```bash
./run.sh build_generator
./run.sh run_generator
```

После этого в папке `data` появится файл `data.csv`.

Сборка и запуск аналитики данных:

```bash
./run.sh build_reporter
./run.sh run_reporter
```

После этого в папке `data` появится файл `report.html`.

Запустить веб-сервер:

```bash
./run.sh report_server
```

Локально отчёт будет доступен по адресу:

```text
http://localhost:1984/report.html
```

## Запуск в GitHub Codespaces

1. Откройте репозиторий в GitHub Codespaces.
2. Откройте терминал.
3. Выполните команды:

```bash
./run.sh build_generator
./run.sh run_generator

./run.sh build_reporter
./run.sh run_reporter

./run.sh report_server
```

4. Откройте вкладку **PORTS** в нижней части окна Codespaces.
5. Найдите порт `1984`.
6. Нажмите **Open in Browser**.

Запрос проходит по следующей цепочке:

```text
Браузер пользователя
        ↓
GitHub Codespaces
        ↓
порт 1984 хоста Codespaces
        ↓
порт 80 контейнера nginx
        ↓
файл data/report.html
```

## Повторный запуск веб-сервера

Перед повторным запуском сервера необходимо остановить уже работающий контейнер:

```bash
docker stop student-report-server
```

Благодаря параметру `--rm` остановленный контейнер будет автоматически удалён.

После этого сервер можно запустить снова:

```bash
./run.sh report_server
```

## Дополнительные команды

Показать структуру проекта:

```bash
./run.sh structure
```

Удалить созданные csv- и html-файлы:

```bash
./run.sh clear_data
```

Создать csv-файл локально без Docker:

```bash
./run.sh create_local_data
```

Проверить содержимое папки `data` из контейнера генератора:

```bash
./run.sh inside_generator
```

Проверить содержимое папки `data` из контейнера аналитика:

```bash
./run.sh inside_reporter
```
