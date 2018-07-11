# my dockerfile
#/etc/nginx/nginx.conf
FROM ubuntu:latest

RUN \
  apt-get update && \
  apt-get install -y wget unzip lua5.1 liblua5.1-0 liblua5.1-0-dev

  RUN wget https://nginx.org/download/nginx-1.15.1.tar.gz
  RUN wget https://github.com/openresty/lua-nginx-module/archive/master.zip
  RUN tar -zxvf nginx-1.15.1.tar.gz -C /root/
  RUN unzip ./master.zip -d /root/module
  RUN rm -f nginx-1.15.1.tar.gz master.zip
  WORKDIR /root/nginx-1.15.1/

RUN ./configure --sbin-path=/usr/local/sbin \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--pid-path=/var/run/nginx.pid \
--user=www-data \
--group=www-data \
--without-http_gzip_module \
--without-http_rewrite_module \
--add-module=/root/module/lua-nginx-module-master

RUN make
RUN make install

RUN rm -rf /var/lib/apt/lists/*
RUN rm -Rf nginx-1.15.1 master

COPY nginx.conf /etc/nginx/
COPY index.html /usr/local/nginx/html

EXPOSE 80
CMD ["/usr/local/sbin/nginx", "-g", "daemon off;"]
