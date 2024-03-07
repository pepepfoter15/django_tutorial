FROM python:3
WORKDIR /usr/local
RUN pip install --root-user-action=ignore --upgrade pip && pip install --root-user-action=ignore django mysqlclient && mkdir static 
COPY . /usr/local
ENV ALLOWED_HOSTS=*
ENV HOST=mariadb
ENV USUARIO=django
ENV CONTRA=django
ENV BASE_DATOS=django
ENV DJANGO_SUPERUSER_PASSWORD=admin
ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_EMAIL=admin@example.org
COPY docker-entrypoint.sh /usr/local/
RUN chmod +x /usr/local/docker-entrypoint.sh
CMD /usr/local/docker-entrypoint.sh
