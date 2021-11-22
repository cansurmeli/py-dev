FROM centos:8

WORKDIR /tmp

RUN dnf update -y
RUN dnf install -y git wget time ca-certificates zsh gcc ncurses-devel make util-linux-user sudo python39 python39-devel python39-setuptools python39-psutil

# Grab Vim fron source instead and compile it with Python3 support
RUN git clone https://github.com/vim/vim.git && cd vim && ./configure --enable-python3interp=yes --with-python3-config-dir=/usr/bin/python3.9/config-* && make && make install

RUN useradd python

RUN usermod -aG wheel python

USER python

WORKDIR /home/python

RUN pip3 install --user --upgrade pip
RUN pip3 install --user pylint

ADD ./requirements.txt /app/requirements.txt
RUN pip3 install --user -r /app/requirements.txt

USER root

# Switch the default shell to Zshell
RUN chsh -s "$(which zsh)"

# Install Zprezto
COPY init_zprezto.sh .

RUN chmod +x init_zprezto.sh

USER python

RUN rm /home/python/.zshrc

RUN ./init_zprezto.sh

# Grab my Vim config
RUN git clone --recursive https://gitlab.cansurmeli.com/can/vim-config /home/python/.vim

WORKDIR /app
