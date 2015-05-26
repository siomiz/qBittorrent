FROM centos:7

MAINTAINER Tomohisa Kusano <siomiz@gmail.com>

COPY build.sh /build.sh
RUN /bin/bash /build.sh \
	&& /bin/rm /build.sh

RUN adduser -m qbittorrent

USER qbittorrent

VOLUME ["/home/qbittorrent"]

COPY qBittorrent.conf /home/qbittorrent/.config/qBittorrent/

EXPOSE 8080

CMD ["/usr/bin/qbittorrent-nox"]
