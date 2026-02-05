FROM ubuntu:22.04

RUN apt-get update && apt-get install -y bind9 bind9utils dnsutils

EXPOSE 53/udp 53/tcp

# Arrancamos el servicio
CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]

