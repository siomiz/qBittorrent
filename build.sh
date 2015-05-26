#!/bin/bash
set -e

# based on https://github.com/qbittorrent/qBittorrent/wiki/Compiling-qbittorrent-nox-for-CentOS-from-source

yum -y groupinstall 'Development Tools'
yum -y install qt-devel boost-devel openssl-devel

curl -L -o /tmp/libtorrent.tar.gz http://sourceforge.net/projects/libtorrent/files/libtorrent/libtorrent-rasterbar-1.0.5.tar.gz
tar zxvf /tmp/libtorrent.tar.gz -C /usr/local/src
cd /usr/local/src/libtorrent*
./configure --disable-debug --prefix=/usr
make
make install
ln -s /usr/lib/pkgconfig/libtorrent-rasterbar.pc /usr/lib64/pkgconfig/libtorrent-rasterbar.pc
ln -s /usr/lib/libtorrent-rasterbar.so.8 /usr/lib64/libtorrent-rasterbar.so.8

git clone https://github.com/qbittorrent/qBittorrent.git /usr/local/src/qBittorrent
cd /usr/local/src/qBittorrent
git checkout release-3.2.0
./configure --disable-gui --prefix=/usr
make
make install

rm -rf /usr/local/src/*
rm /tmp/libtorrent.tar.gz
yum -y remove qt-devel boost-devel openssl-devel
yum -y groupremove 'Development Tools'
yum -y autoremove
yum clean all

exit 0

