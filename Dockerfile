FROM ubuntu:22.04

RUN apt update && apt install -y ffmpeg curl jq

WORKDIR /app
COPY . .

RUN chmod +x run.sh

CMD ["bash", "./run.sh"]
