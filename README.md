This is a Dockerfile for mutt-wizard, to simplify the already simple installation and have it in a super fun happy container.

Runs on an Arch Linux base, because that's what Luke uses (or used) for awhile, but I might change it to Alpine in the future.

### Building/Running

Either clone & run the included `start.sh`, or

```
git clone https://github.com/meowmix3/muttwizard-docker.git
cd muttwizard-docker
docker build -t muttwizard .
docker run -itd \
	--name=muttwizard \
	-e TZ=America/New_York \
	-u 1000:1000 \
	-v $(pwd)/data:/home/user \
muttwizard
```

Configure the gpg/pass info
```
# Go through the dialogs to generate a GPG key
docker exec -it muttwizard /usr/bin/gpg --full-gen-key
# Enter the GPG email you used to configure pass
docker exec -it /usr/bin/pass init <yourGPGemail>
# Add an account
docker exec -it /usr/local/bin/mw add
# Restart the container
docker restart muttwizard
```

To add more emails run
`docker exec -it muttwizard /usr/local/bin/mw add` 

The included `mw cron` does not work because cronie is not installed, to auto sync emails add something like this to your host crontab (if you GPG key does not have a passphrase)

`*/15 * * * * * docker exec -t muttwizard /usr/bin/mbsync -a`

Also includes a `update.sh` to rebuild the container.

### Please!
Feel free to message me, open issues, make a pull request, or suggest any changes!

Thanks to the lovely Luke Smith for muttwizard, check out [his repo](https://github.com/LukeSmithxyz/mutt-wizard) for more info.
