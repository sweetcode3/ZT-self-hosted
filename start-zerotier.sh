#!/bin/bash

# Запуск ZeroTier и подключение к сети
echo "Подключаемся к сети ZeroTier с Network ID: $ZEROTIER_NETWORK_ID"
zerotier-cli join $ZEROTIER_NETWORK_ID

# Проверяем, подключен ли узел к сети
until zerotier-cli info | grep -q "ONLINE"; do
    echo "Ожидаем подключения к сети ZeroTier..."
    sleep 5
done

# Настройка статического IP для узла
echo "Настройка статического IP: $ZEROTIER_NODE_IP"
zerotier-cli set $ZEROTIER_NETWORK_ID ip $ZEROTIER_NODE_IP

# Настройка выходной ноды через шлюз
if [ ! -z "$ZEROTIER_GATEWAY_IP" ]; then
    echo "Настройка выходной ноды с IP: $ZEROTIER_GATEWAY_IP"
    ip route add default via $ZEROTIER_GATEWAY_IP
fi

# Автоматическая проверка состояния ZeroTier и перезапуск в случае сбоев
while true; do
    if ! zerotier-cli info | grep -q "ONLINE"; then
        echo "ZeroTier не в сети. Переподключаемся..."
        zerotier-cli leave $ZEROTIER_NETWORK_ID
        zerotier-cli join $ZEROTIER_NETWORK_ID
    fi
    sleep 30
done
