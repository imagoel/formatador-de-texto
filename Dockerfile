FROM nginx:1.27-alpine

COPY index.html /usr/share/nginx/html/index.html
COPY format.html /usr/share/nginx/html/format.html
COPY templates /usr/share/nginx/html/templates
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1/ || exit 1
