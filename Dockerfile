FROM nvidia/opencl:runtime

RUN apt-get update && apt-get install -y --no-install-recommends \
  zip \
  git \
  python3 \
  python3-psutil \
  python3-requests \
  pciutils \
  curl && \
  rm -rf /var/lib/apt/lists/*

CMD mkdir /root/htpclient

WORKDIR /root/htpclient

RUN git clone https://github.com/s3inlc/hashtopolis-agent-python.git && \
  cd hashtopolis-agent-python && \
  ./build.sh

FROM nvidia/opencl:runtime


RUN apt-get update && apt-get install -y --no-install-recommends \
  python3 \
  python3-psutil \
  python3-requests \
  pciutils && \
  rm -rf /var/lib/apt/lists/* 

CMD mkdir /root/htpclient

WORKDIR /root/htpclient

COPY --from=0 /root/htpclient/hashtopolis-agent-python/hashtopolis.zip ./
