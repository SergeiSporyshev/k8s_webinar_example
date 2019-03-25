FROM node:6.11 as builder

RUN npm install -g gulp

COPY ./package.json ./gulpfile.js ./webpack.mix.js /var/www/vhosts/site/
RUN cd /var/www/vhosts/site \
    && npm install

COPY ./ /var/www/vhosts/site

RUN cd /var/www/vhosts/site \
    && gulp --production \
    && npm run prod


FROM nginx

COPY ./kube/nginx /etc/nginx

COPY --from=builder /var/www/vhosts/site/public /var/www/vhosts/site/public

CMD ["nginx", "-g", "daemon off;"]