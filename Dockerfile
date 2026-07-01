FROM registry.access.redhat.com/ubi9/httpd-24

COPY frontend-app/* /var/www/html/

EXPOSE 8080
