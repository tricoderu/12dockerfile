# Используем официальный образ Go как базовый образ
FROM golang:1.22.4 AS builder

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем go.mod и go.sum в контейнер
COPY go.mod go.sum ./

# Загружаем зависимости
RUN go mod download

# Копируем весь код приложения
COPY . .

# Собираем приложение
RUN go build -o myapp .

# Используем небольшой образ для запуска приложения
FROM alpine:latest

# Переносим собранное приложение в новый образ
WORKDIR /root/
COPY --from=builder /app/myapp .

# Открываем порт
EXPOSE 8080

# Указываем, какую команду выполнять в контейнере
CMD ["./myapp"]
