# Используем базовый образ Ubuntu
FROM ubuntu:20.04

# Устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    iproute2 \
    && rm -rf /var/lib/apt/lists/*

# Добавляем репозиторий ZeroTier и устанавливаем его
RUN curl -s https://install.zerotier.com | bash

# Копируем скрипт для подключения к сети ZeroTier
COPY start-zerotier.sh /start-zerotier.sh
RUN chmod +x /start-zerotier.sh

# Указываем команду для запуска скрипта
CMD ["/start-zerotier.sh"]
