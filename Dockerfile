FROM cgr.dev/chainguard/nginx:latest

WORKDIR /usr/share/nginx/html
COPY build .

EXPOSE 8080