# docker build -t snx:base .

FROM mwendler/wget as pre_build
WORKDIR /storage
# adjust list of {environments} here when needed
# pay attention to the name {prefixes}, i.e. {prod}, {lab}, etc.
# {prefix} equals to the {environment}

# i.e.
RUN wget --no-check-certificate https://lab.vpn-gateway.com/sslvpn/SNX/INSTALL/snx_install.sh -O lab.snx_install.sh
RUN wget --no-check-certificate https://prod.vpn-gateway.com/CSHELL/snx_install.sh -O prod.snx_install.sh

FROM ubuntu:20.04

RUN dpkg --add-architecture i386 \
 && apt update \
 && apt install -y \
   kmod \
   libstdc++5:i386 \
   libpam0g:i386 \
   libx11-6:i386 \
 && rm -rf /var/lib/apt/lists/*

WORKDIR snx

ENV HOST placeholder
ENV USER placeholder
ENV PASS placeholder

# this is your default preferred {environment}
ENV ENV lab

COPY docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh

ENTRYPOINT ["/snx/docker-entrypoint.sh"]


COPY --from=pre_build /storage .

RUN chmod +x ./*.sh

