#!/bin/sh
. /etc/openwrt_release
HOME="https://raw.githubusercontent.com/extrepo/openwrt/main/${DISTRIB_RELEASE}"
JMODEM="${HOME}/packages/${DISTRIB_ARCH}/jmodem"
cd /tmp
if [ ! "$(grep jmodem /etc/opkg/customfeeds.conf)" ]; then
    wget -q ${JMODEM}/Packages.gz -O /dev/null
    case $? in
	0)
	    echo "src/gz jmodem ${JMODEM}" >> /etc/opkg/customfeeds.conf
	    wget ${HOME}/key-build.pub
	    opkg-key add key-build.pub
	;;
	*) echo "Failed add repository!"
    esac
fi
