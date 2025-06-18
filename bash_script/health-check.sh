#!/bin/bash

# Значения по умолчанию
HOST=${1:-127.0.0.1}
PORT=${2:-80}
LOG_FILE="/var/log/port-check.log"

# Проверка порта с помощью nc (netcat)
if nc -z -w3 $HOST $PORT 2>/dev/null; then
    echo "$(date): $HOST:$PORT доступен"
else
    echo "$(date): $HOST:$PORT недоступен" >> "$LOG_FILE"
fi