From: lkp@intel.com (kbuild test robot)
Date: Sun, 20 May 2018 04:59:58 +0800
Subject: [arm:sa1100 80/87] ERROR: "ipaq_micro_tx_msg"
 [arch/arm/mach-sa1100/h3xxx-sleeve.ko] undefined!
Message-ID: <201805200454.F8TwgQD5%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git sa1100
head:   6713179ef01a294e21b4b2ff808a8d30155af2ad
commit: 6b9bc7e8128e38bc39eea71789c6e914f13b6d5a [80/87] ARM: sa1100/h3xxx: sleeve support
config: arm-neponset_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6b9bc7e8128e38bc39eea71789c6e914f13b6d5a
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: "ipaq_micro_tx_msg" [arch/arm/mach-sa1100/h3xxx-sleeve.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 15702 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180520/f81d3c9c/attachment-0001.gz>
