1. Сделать скрипт исполняемым


chmod +x ~/scripts/health-check.sh

переместить его в стандартное место

sudo mv ~/scripts/health-check.sh /usr/local/bin/health-check.sh

Также можно добавить его как сервис с таймером для автоматической проверки на определённых промежутках времени.

2. Создаем сервис health-check.service

расположен в /etc/systemd/system

sudo nano /etc/systemd/system/health-check.service

[Unit]
Description=Проверка доступности порта через Bash-скрипт
After=network.target

[Service]
ExecStart=/usr/local/bin/health-check.sh 127.0.0.1 80

Заменить по надобности 127.0.0.1 80 на нужный.


3. Создаем systemd-таймер

sudo nano /etc/systemd/system/health-check.timer


[Unit]
Description=Таймер для проверки порта каждую минуту

[Timer]
OnBootSec=30s
OnUnitActiveSec=60s
Unit=health-check.service

[Install]
WantedBy=timers.target

4. Перезапустить systemd и активировать таймер

sudo systemctl daemon-reload
sudo systemctl enable --now health-check.timer