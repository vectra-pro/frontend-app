FROM registry.access.redhat.com/ubi8/httpd-24:1782839205

COPY . /var/www/html/

EXPOSE 8080
