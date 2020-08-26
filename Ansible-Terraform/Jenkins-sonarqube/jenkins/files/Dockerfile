FROM jenkins/jenkins:lts

USER root

ENV DOCKERVERSION=19.03.6

# Installing docker
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz \
  && groupadd -g 999 docker \ 
  && usermod -aG staff,docker jenkins

# Replace "999" on line no. 11 with docker group id of your host

# Installing kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
	&& chmod +x ./kubectl \
	&& mv ./kubectl /usr/local/bin/kubectl

# Installing AWS cli for iam authentication
RUN apt-get update \
  && apt install python3-pip -y \
  && pip3 install awscli --upgrade

USER jenkins