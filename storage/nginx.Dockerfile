FROM nginx

COPY ./kube/nginx /etc/nginx

COPY ./public /var/www/vhosts/site/public

CMD ["nginx", "-g", "daemon off;"]