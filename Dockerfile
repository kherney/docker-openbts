FROM ubuntu:xenial

ENV APT="apt-get -y"
ENV USER="radio"
RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

USER root
RUN ${APT} update && ${APT} upgrade
RUN DEBIAN_FRONTEND=noninteractive ${APT} install \
                    software-properties-common \
                    python-software-properties \
                    git \
                    wget \
                    dpkg-dev \
                    debhelper \
                    sudo

RUN DEBIAN_FRONTEND=noninteractive ${APT} install libuhd-dev || $(APT) update --fix-missing?
RUN adduser --disabled-password ${USER}
RUN adduser ${USER} sudo

WORKDIR /etc/
RUN > sudoers &&\
    echo 'root ALL=(ALL) ALL\n' >> sudoers &&\
    echo 'radio ALL=(ALL) NOPASSWD: ALL\n' >> sudoers &&\
    echo 'Defaults    env_reset\n' >> sudoers &&\
    echo 'Defaults    secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"\n' >> sudoers
RUN cat sudoers
RUN chmod 440 /etc/sudoers

USER ${USER}
WORKDIR /home/${USER}
RUN git clone https://github.com/RangeNetworks/dev.git
WORKDIR dev
RUN ./clone.sh
RUN sed -i '/`date +"%Y-%m-%d--%H-%M-%S"`/c\BUILDNAME=BUILDS' build.sh
RUN ./build.sh N210 
USER root
WORKDIR BUILDS
RUN dpkg -i *.deb || \
    DEBIAN_FRONTEND=noninteractive ${APT} install -f || \
    dpkg --force-confnew -i range-configs*.deb range-asterisk-config*.deb

USER ${USER}
WORKDIR /home/${USER}
RUN git clone https://github.com/nadiia-kotelnikova/openbts_systemd_scripts.git
USER root
RUN cp /home/${USER}/openbts_systemd_scripts/systemd/* /etc/systemd/system
WORKDIR /OpenBTS

RUN ${APT} install openssh-server
RUN sed -i 's/^Port 22$/Port 39775/' /etc/ssh/sshd_config
RUN sed -i 's/^PermitEmptyPasswords no$/PermitEmptyPasswords yes/' /etc/ssh/sshd_config

VOLUME /etc/OpenBTS
CMD ["/sbin/init"]
