smileplug-bsp
=============

This is a bunch of initial config.  This will include a set of configs to be applied in the BSP.

Release Sources
===============
Kernel and wifi sources:

* https://github.com/kmihelich/linux-smileplug
* https://github.com/kmihelich/wlan-smileplug

The *Non-public* toolchain needed is listed under the "Generic SDK 5.0" on the extranet.  Due to some incompatibilities with the WLAN driver and Kernel, we were unable to build with a publicly available toolchain.  Please contact Marvell for access and to resolve build support issues.  Folder location is: My Products > Embedded Processors > ARMADA 370 > Software > Old Versions > Generic SDK 5.0 > Little Endian

Current RootFS: 

* Rootfs Tarball: http://polyblog.s3.amazonaws.com/ArchLinuxARM-2013-12-13-smileplug-0.5.4a-rootfs.tar.bz2
* Rootfs Tarball md5: http://polyblog.s3.amazonaws.com/ArchLinuxARM-2013-12-13-smileplug-0.5.4a-rootfs.tar.bz2.md5
* Rootfs Image: http://polyblog.s3.amazonaws.com/smileplugbsp-0.5.4a-rootfs.img
* Rootfs Image md5 hash: http://polyblog.s3.amazonaws.com/smileplug-0.5.4a-rootfs.img.md5

All items mentioned in this page are found in a single zip file *TODO* update this zip:
    http://smilec.s3.amazonaws.com/smileplugbom-0.5.2.zip

Clean and Configuration Guide

Use this doc to help you get your configuration set up and remove any SMILE software you don't need.

* PDF Document: https://www.dropbox.com/s/6cj36bomfmzvyal/SMILEPlugCleanAndConfigGuide.pdf

WiFi Conifguration Notes

The Wireless Module, AP-8764 has it's source code for the driver released under GPLv2 license (see above).   The
localation of the configuration tools man pages or detailed docs specific to the AP-8764 are proprietary and only
available through the tools vendors.  Because the tools are GPLv2, the sources for the tools should be published
somewhere.  

Here are some basic notes in GIST form to cover WPA2 configuration: https://gist.github.com/truedat101/6646367


General Arch Linux Arm details on SMILE Plug release (NOTE, this is not current, as the Arch Linux ARM team has not yet officially posted a support link for this device yet):

* http://archlinuxarm.org/smileplugi (TODO: No longer supports NAND-based installation onto SMILE Plugs, need to update for MMC based install)

Pacman Package Manifest
=======================

* nodejs
* openssl
* make
* unzip
* gcc
* sysstat (we just use sar)
* python
* python2-distribute
* python2-pyopenssl
* iperf
* ntp (not openntpd)
* udev-automount

> pacman -S openssl gcc nodejs make

NPM Modules:

* forever (install in global)
* forever-webui (npm package is busted, public repo is defunt, so we have forked here, off HEAD of https://github.com/truedat101/forever-webui.git) ,
  wget  https://nodeload.github.com/truedat101/forever-webui/tar.gz/master , install dependencies, access on port 8085
* ccn4bnode (0.2.8)

Other Non-NPM Node Software:

* SMILE Server 1.0.0 (this holds pointers to all Android software used)
* Plugmin Server 0.5.8
* EpochEDU 0.6.0

Scripts:
* dhcpd-status.sh -> /root/spdist/dhcpd-pool-0.2/dhcpd-status-arch.sh

General Config
==============

* Standard root password: root // XXX CHANGE ME
* .bashrc in /root is used
* set default root PATH to include ~/root/bin


Assigned Ports
==============

* 80 (SMILE and JS.js) - We really need to put all of this behind a reverse proxy
* 8008 (TTY.js)
* 8085 (forever-webui)
* 9023 (NIDE)
* 9695 (CCNx CCND Status)
* 9700 (CCN4BNode Web UI)
* 9080 (plugmin WS/Web UI)
* 5000 (epochedu)

Python Modules:

* curl -O http://python-distribute.org/distribute_setup.py
* sudo python distribute_setup.py
* sudo easy_install pip
* sudo pip install virtualenv
* sudo pip install virtualenvwrapper

Additional Software:

* virtualenv goenv
* . ./goenv/bin/activate
* A sample project for NIDE to use: https://github.com/jed/browserver-node/archive/master.tar.gz
 (put into spdist, needs its package depends included)

Users & Groups:

* Default Root and SUDO configuration, see: http://archlinuxarm.org/support/guides/system/first-steps
* No other non-default users

Added for testing:

* ntop
* afps-fs (may consider adding this to above list)

Some manual commands to run in the configuration of a new BSP based on arch:

* For UFW, open all connections from the associated networks for the administrative 
  network 10.0.0.0 and the default WIFI AP network 10.1.0.0
    # This generates the /usr/lib/ufw/user.conf commands used to store the rules
    ufw allow from 10.0.0.0/24
    ufw allow from 10.1.0.0/24
* setup the timezone for America/Los_Angeles
/etc/localtime -> /usr/share/zoneinfo/America/Los_Angeles
* Configure time: 
    > ntpd -qg (Need to set up NTP at this point or else openssl won't work properly )
    > hwclock -w

Firmware Releases Changelog
===========================

SMILE BSP 0.5.4a
* rootfs: TBD
* uImage (kernel): TBD
* uBoot: TBD
* ubifs rootfs.img: TBD

SMILE BSP 0.5.3 (TODO: Provide archive links)
* rootfs: TBD
* uImage (kernel): TBD
* uBoot: TBD
* ubifs rootfs.img: TBD

Arch Linux ARM Tips
===================

* Until we complete the migration to the mainline Arch Linux ARM community release (and more modern kernel), it is not recommended to attempt to run a complete upgrade
* If you need to install packages from AUR, you minimally will want to run as root: pacman -Sy <package name>

Roadmap
=======

* 0.5.4b - Release quality 1.0.x SMILE Plug Server
* 0.5.4a - Finalize SMILE Plug Server 1.0.0 release candidate, remove 3rd party encumbrances, still some pre-alpha bugs
* 0.5.3b - Release additional SMILE software bug fixes (0.3.x)
* 0.6.0 - Complete migration to mainlain Arch Linux ARM distro
