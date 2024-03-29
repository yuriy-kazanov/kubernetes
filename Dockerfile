# Создаем временный Докер-образ и называем его builder
FROM golang:1.18 AS builder
WORKDIR /app
COPY . .
# Компилируем приложение специально для дальнейшего запуска в Alpine
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

# Создаем финальный Докер-образ на базе легковесного alpine
FROM alpine:latest
WORKDIR /root/
#Копируем собранное приложение из образа biulder
COPY --from=builder ./app .
EXPOSE 8080
CMD ["./app"]
