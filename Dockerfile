FROM python:3
WORKDIR /usr/local
RUN pip install --root-user-action=ignore --upgrade pip && pip install --root-user-action=ignore django mysqlclient && mkdir static 
COPY . /usr/local
COPY docker-entrypoint.sh /usr/local/
RUN chmod +x /usr/local/docker-entrypoint.sh
RUN git clone https://github.com/Mario-Zayas/django_tutorial.git ./
CMD /usr/local/docker-entrypoint.sh
