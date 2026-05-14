   FROM nginxinc/nginx-unprivileged:1.27-alpine AS runtime
   COPY --from=builder --chown=nginx:nginx /app/build-output/ /usr/share/nginx/html/
   COPY --chown=nginx:nginx nginx.conf /etc/nginx/templates/default.conf.template
   USER nginx
   EXPOSE 8080