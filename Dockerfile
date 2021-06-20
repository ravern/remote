FROM ubuntu:20.04

ARG PASSWORD

WORKDIR /root

RUN printf "${PASSWORD}\n${PASSWORD}\n" | passwd

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y curl

RUN wget -O /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.6.3/ttyd.x86_64
RUN chmod +x /usr/local/bin/ttyd

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

RUN curl https://get.volta.sh | bash -s -- --skip-setup
RUN /root/.volta/bin/volta install node@12
RUN /root/.volta/bin/volta install yarn

EXPOSE 7681

ENTRYPOINT ["ttyd", "login"]
