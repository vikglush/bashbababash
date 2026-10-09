#!/usr/bin/env bash
set -e

# Отключаем любые интерактивные диалоги и вопросы от apt/debconf
export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

echo "=== 1. Обновление списка пакетов и системы ==="
sudo -E apt-get update
sudo -E apt-get upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"

echo "=== 2. Установка утилит ==="
# Устанавливаем базовые утилиты и зависимости
sudo -E apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    wget \
    unzip \
    traceroute \
    nmap \
    iperf3 \
    mtr-tiny \
    tcpdump

echo "=== 3. Загрузка и распаковка qms_lib ==="
TARGET_URL="https://lib.speedtest.ru/bin/linux_arm64/qms_lib.zip"
ZIP_FILE="qms_lib.zip"

wget -O "$ZIP_FILE" "$TARGET_URL"
unzip -o "$ZIP_FILE"

# Назначаем права на исполнение
if [ -f "qms_lib" ]; then
    chmod +x qms_lib
elif [ -f "qms_lib/qms_lib" ]; then
    chmod +x qms_lib/qms_lib
fi

echo "=== Установка успешно завершена! ==="
