FROM debian:buster-slim
# set locale + editor
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV EDITOR nvim
# install dependencies
RUN apt update 
RUN apt install -y \
	git \
	pass \
	neomutt \
	lynx \
	isync \
	msmtp \
	make \
	tzdata \
	neovim \
	python3-pip \
	urlview \
	notmuch
# clone & make
RUN git clone https://github.com/LukeSmithxyz/mutt-wizard.git && \
	cd mutt-wizard && \
	make install
RUN pip3 install --no-cache-dir \
        vdirsyncer \
        khard
# add user
RUN useradd -ms /bin/bash user
USER user
WORKDIR /home/user
ENTRYPOINT /usr/bin/neomutt
