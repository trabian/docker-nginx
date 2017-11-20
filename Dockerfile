FROM nginx:1.13.6

RUN rm /etc/nginx/nginx.conf /etc/nginx/mime.types
COPY nginx.conf /etc/nginx/nginx.conf
COPY basic.conf /etc/nginx/basic.conf
COPY mime.types /etc/nginx/mime.types
RUN mkdir /etc/nginx/ssl
RUN mkdir /etc/nginx/sites-enabled
COPY default /etc/default.config
COPY default-ssl /etc/nginx/sites-available/default-ssl
COPY directive-only /etc/nginx/directive-only
COPY location /etc/nginx/location

ENV PORT=8080

# expose both the HTTP (80) and HTTPS (443) ports
EXPOSE 8080 443

CMD /bin/bash -c "envsubst '\$PORT' < /etc/default.config > /etc/nginx/sites-enabled/default && nginx"