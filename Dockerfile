FROM registry.opensuse.org/opensuse/tumbleweed:latest

# basic config
RUN zypper --no-gpg-checks --non-interactive update --no-recommends
RUN zypper --no-gpg-checks --non-interactive install --no-recommends wget curl which util-linux coreutils systemd grep usbutils libcap-progs net-tools-deprecated tar lsof iproute2 binutils

ARG DEB_URL
RUN wget "$DEB_URL" -O /tmp/fr24.deb
RUN ar x /tmp/fr24.deb
RUN tar -vxf /data.tar.gz
RUN rm -vrf /tmp/fr24.deb /data.tar.gz /control.tar.gz /debian-binary
