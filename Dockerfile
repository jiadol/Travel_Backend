FROM tensorflow/tensorflow:latest-gpu

COPY --chown=root:root . /root/

WORKDIR /root

RUN apt update && \
    apt install -y python3-dev default-libmysqlclient-dev build-essential pkg-config && \
    pip install -r requirements.txt  --no-cache-dir && \
    python manage.py makemigrations && \
    python manage.py migrate && \
    apt clean

CMD ["python", "/root/manage.py", "runserver", "0.0.0.0:8000"]

EXPOSE 8000

