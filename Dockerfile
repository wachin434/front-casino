FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

RUN npm run build --configuration=production
FROM nginxinc/nginx-unprivileged:1.27-alpine AS runtime
COPY --from=builder --chown=nginx:nginx /app/dist/vidal-casino/ /usr/share/nginx/html/
COPY --chown=nginx:nginx nginx.conf /etc/nginx/templates/default.conf.template

USER nginx
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]