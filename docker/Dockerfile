FROM centos:8

WORKDIR /tmp

RUN dnf update -y
RUN dnf install -y git wget time ca-certificates zsh gcc ncurses-devel make python3 util-linux-user sudo
RUN git clone https://github.com/vim/vim.git && cd vim && ./configure --enable-python3interp=yes && make && make install

RUN useradd python

RUN usermod -aG wheel python

USER python

WORKDIR /home/python

RUN pip3 install --user --upgrade pip
RUN pip3 install --user pylint

ADD ./requirements.txt /app/requirements.txt
RUN pip3 install --user -r /app/requirements.txt

# To handle a stupid issue related to Git cloning when
#		installing Vim plugins. Detailed in the URL:
# https://nlknguyen.wordpress.com/2016/06/03/vim-tip-fix-plugin-loading-error-not-an-editor-command-m/
RUN git config --global core.autocrlf input

# TEMPORARY
# Currently, there is an issue with cloning my Gitlab repo
# Probably due to the fact that this is a slim installation
#		that necessary stuff isn't there.
RUN git config --global http.sslverify false

RUN git clone https://gitlab.cansurmeli.com/can/vim-config /home/python/.vim

#SHELL ["/usr/bin/zsh"]

RUN git clone --recursive https://github.com/sorin-ionescu/prezto.git /home/python/.zprezto

USER root

COPY init_zsh.sh .

RUN chmod +x init_zsh.sh

#RUN ./init_zsh.sh

# Make Zsh the default shell
RUN chsh -s /bin/zsh

USER python

WORKDIR /app
