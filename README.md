# ZeroTier Docker Setup for Self-hosted Runner

## Описание
Этот проект позволяет настроить и запустить контейнер ZeroTier в self-hosted GitHub runner, подключая его к вашей сети ZeroTier с заданным статическим IP. Также предусмотрена автоматическая настройка шлюза и проверка состояния подключения.

## Инструкция по настройке

1. Создайте репозиторий на GitHub.
2. Перейдите в **Settings** -> **Secrets** и добавьте следующие секреты:
   - `zerotier_network_id` — ID вашей ZeroTier сети.
   - `zerotier_api_token` — API токен для работы с ZeroTier.
   - `zerotier_node_ip` — статический IP, который будет назначен вашему узлу (например, 192.168.88.5).
   - `zerotier_gateway_ip` — IP шлюза (если необходимо).

3. Добавьте workflow файл `zerotier-setup.yml` в директорию `.github/workflows/`.
4. Сделайте push в основную ветку или запустите workflow вручную через GitHub.
5. Workflow создаст и запустит контейнер с ZeroTier. Контейнер автоматически подключится к сети и настроит статический IP.

## Примечания
- Обратите внимание, что для корректной работы требуется доступ к интернету с вашего self-hosted runner.
- Если вы хотите настроить выходную ноду, укажите её IP в секрете `zerotier_gateway_ip`.
- 

# Structure:
```
.
├── .github
│   └── workflows
│       └── zerotier-setup.yml
├── Dockerfile
├── docker-compose.yml
└── README.md
```
