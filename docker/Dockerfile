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

ADD ./requirements.txt /app/requirements.txt
RUN pip3 install --user -r /app/requirements.txt

#   I need the rich/colourful environment experience
# Plus, it possibly solves a Prompt.app issue on iOS/iPadOS
RUN export TERM="screen-256color"

#   Define the appropiate Python path so that the Python
# import works properly
RUN export PYTHONPATH="/app/code/"

# Basic aliases to avoid minor inconviences
RUN alias pip=pip3
RUN alias python=python3

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
