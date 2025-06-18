# redbox
Тестовое задание на позицию стажер DevOps
# DockerCompose
🔹 db — PostgreSQL

image: использует официальный образ PostgreSQL 15.

environment: задаёт параметры БД:
POSTGRES_USER: имя пользователя.
POSTGRES_PASSWORD: пароль.
POSTGRES_DB: имя создаваемой базы.

volumes: сохраняет данные в томе pgdata, чтобы они не терялись при пересоздании контейнера.

ports: пробрасывает порт 5432 на хост для внешнего подключения к БД.


🔹 redis — Redis

image: официальный образ Redis версии 7.

ports: пробрасывает порт Redis наружу на 6379.


🔹 php — пользовательский PHP-сервис

context: путь до каталога, содержащего Dockerfile (в данном случае ./php).

dockerfile: имя Dockerfile.

environment: переменные окружения для подключения к Redis и PostgreSQL.

volumes: монтирует локальную папку php внутрь контейнера по пути /var/www/html.

depends_on: указывает, что сначала должны быть запущены db и redis.


🔹 nginx — веб-серверyaml

image: использует свежий образ Nginx.

ports: пробрасывает порт 80 на хост (доступен через http://localhost).

volumes:

Монтирует конфигурационный файл nginx внутрь контейнера.
Монтирует код из php, чтобы nginx имел доступ к PHP-скриптам.

depends_on: запускается только после запуска php.



🔹 volumes

volumes:
  pgdata:

Определяет именованный том pgdata, который используется для хранения данных PostgreSQL (/var/lib/postgresql/data).

Это нужно для сохранения данных между перезапусками.