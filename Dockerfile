FROM registry.opensuse.org/opensuse/tumbleweed:latest

# basic config
RUN zypper addrepo https://download.opensuse.org/repositories/hardware:sdr/openSUSE_Tumbleweed/hardware:sdr.repo
RUN zypper --no-gpg-checks --non-interactive update --download-as-needed --no-recommends
RUN zypper --no-gpg-checks --non-interactive install --download-as-needed --no-recommends wget curl which util-linux coreutils systemd grep usbutils libcap-progs net-tools-deprecated tar lsof iproute2 binutils tini strace make gcc rtl-sdr-devel

ARG DEB_URL
RUN wget "$DEB_URL" -O /tmp/fr24.deb
RUN ar x /tmp/fr24.deb
RUN tar -vxf /data.tar.gz
RUN rm -vrf /tmp/fr24.deb /data.tar.gz /control.tar.gz /debian-binary

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/init.sh"]
COPY init.sh /
RUN chmod +x /init.sh

COPY dump1090 /opt/dump1090
RUN make -C /opt/dump1090
RUN mkdir -p /usr/lib/fr24 && \
	ln -vsnf /opt/dump1090/dump1090 /usr/lib/fr24/dump1090 && \
	ln -vsnf /bin/true /sbin/rmmod && \
	ln -vsnf /bin/true /sbin/modprobe
