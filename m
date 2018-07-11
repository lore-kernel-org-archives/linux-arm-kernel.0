From: lkp@intel.com (kbuild test robot)
Date: Wed, 11 Jul 2018 23:11:18 +0800
Subject: [arm:sa1100 80/87] ERROR: "ipaq_micro_tx_msg"
 [arch/arm/mach-sa1100/h3xxx-sleeve.ko] undefined!
Message-ID: <201807112316.oCyH9HDa%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git sa1100
head:   a656109767f78dbd0d04850495673834d5da2832
commit: 6c78d2dfeaaef97193d49ceb527d9e9064124eaa [80/87] ARM: sa1100/h3xxx: sleeve support
config: arm-neponset_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6c78d2dfeaaef97193d49ceb527d9e9064124eaa
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: "ipaq_micro_tx_msg" [arch/arm/mach-sa1100/h3xxx-sleeve.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 15692 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180711/b79cff27/attachment-0001.gz>
