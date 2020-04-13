FROM debian:buster-slim
# set locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
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
	notmuch
RUN locale-gen
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
