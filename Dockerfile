#checkov:skip=CKV_DOCKER_2
#checkov:skip=CKV_DOCKER_3
FROM python:3.12-slim@sha256:59c7332a4a24373861c4a5f0eec2c92b87e3efeb8ddef011744ef9a751b1d11c
LABEL org.opencontainers.image.source https://github.com/github/evergreen

WORKDIR /action/workspace
COPY requirements.txt *.py /action/workspace/

RUN python3 -m pip install --no-cache-dir -r requirements.txt \
    && apt-get -y update \
    && apt-get -y install --no-install-recommends git-all=1:2.39.2-1.1 \
    && rm -rf /var/lib/apt/lists/*

CMD ["/action/workspace/evergreen.py"]
ENTRYPOINT ["python3", "-u"]
