FROM python:3.6.1

WORKDIR /tmp

RUN apt-get update -y
RUN apt-get install -y git ncurses-dev
RUN git clone https://github.com/vim/vim.git && cd vim && ./configure --enable-python3interp=yes && make && make install

ADD ./requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt

COPY .vim /root/.vim

WORKDIR /app
