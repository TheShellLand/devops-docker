FROM ubuntu:18.04

LABEL maintainer="naisanza@gmail.com"
LABEL description="For all your devops things"
LABEL dockername="theshellland/devops-docker"

ENV INSTALL /install

WORKDIR $INSTALL
RUN apt update && apt upgrade -y
RUN apt update && apt install -y git
RUN \
    # clone repo
    git clone https://github.com/TheShellLand/antsable \
    \
    # install
    && cd antsable \
    && ./ansible.sh playbooks/ssh-docker.yaml -l local -c local \
    && ./ansible.sh playbooks/devops.yaml -l local -c local \
    \
    # cleanup
    && rm -rf $INSTALL \
    && apt autoclean -y; apt clean; apt autoremove -y

WORKDIR /

# copy entrypoint
COPY entry.sh .

WORKDIR /root

VOLUME ["/etc/ssh"]
VOLUME ["/root"]

# ssh port
EXPOSE 22

# shell
CMD ["/bin/bash"]

# start ssh
ENTRYPOINT ["/bin/bash", "/entry.sh"]
