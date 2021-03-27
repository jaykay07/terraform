#!/bin/sh
yum install epel -y
yum install nginx -y
echo -e "upstream backend { \n server dockerhost1:8080; \n    server dockerhost2:8080; \n}" > /etc/nginx/conf.d/load-balancer.conf
echo -e "location { \n proxy_pass http://backend/; \n}" > /etc/nginx/conf.d/load-balancer.conf
systemctl enable nginx
systemctl restart nginx

