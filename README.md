# Prerequisites
* ZSH shell
* Docker
* Linux
* You are using [Checkpoint VPN](https://www.checkpoint.com/) = )

# Usage
```sh
# Establish VPN connectivity to {prod} environment
vpn prod
# Establish VPN connectivity to {lab} environment
vpn lab
```

# Pros
* You only need Docker and ZSH on your machine
* Easy to use
* Automatically disconnects previously established connections (see `zshrc_alias`)
* Customizable and flexible (see `Dockerfile`)
* Tested under `Ubuntu 20.04`

# Installation
* Add your `environments` to `Dockerfile`:
```sh
# pay attention to the name {prefixes}, i.e. {prod}, {lab}, etc.
# {prefix} equals to the {environment}
# for instance:
RUN wget --no-check-certificate https://lab.vpn-gateway.com/sslvpn/SNX/INSTALL/snx_install.sh -O lab.snx_install.sh
RUN wget --no-check-certificate https://prod.vpn-gateway.com/CSHELL/snx_install.sh -O prod.snx_install.sh
```
* Build image `snx:base` from `Dockerfile`:
```sh
docker build -t snx:base .
```
* Copy content of `.zshrc_alias` into your `~/.zshrc`:
```sh
cat .zshrc_alias >> ~/.zshrc
```
* Create credentials for your `environments`:
```sh
# Just for instance

# prod
cat <<EOT >> ~/.credentials/vpn/prod.creds
HOST=prod.vpn-gateway.com
USER=YOUR_NAME
PASS=YOUR_PASSWORD
ENV=prod

# lab
cat <<EOT >> ~/.credentials/vpn/lab.creds
HOST=lab.vpn-gateway.com
USER=YOUR_NAME
PASS=YOUR_PASSWORD
ENV=lab
```
* Installation accompiled.


# Useful cases
* Check connectivity logs
```sh
docker logs -f my-vpn-${ENVIRONMENT_NAME}
```