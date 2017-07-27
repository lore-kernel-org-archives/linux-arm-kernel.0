From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 27 Jul 2017 14:39:55 +0800
Subject: [arm:sa1100 107/115] ERROR: "ipaq_micro_tx_msg"
 [arch/arm/mach-sa1100/h3xxx-sleeve.ko] undefined!
Message-ID: <201707271453.qe4PBMNQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git sa1100
head:   3e9a00e39f7234ef4ef6dc947facd8b0370ba291
commit: 9a8b302c61235a29fef343a13c11d38bfbac8ea3 [107/115] ARM: sa1100/h3xxx: sleeve support
config: arm-cerfcube_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 9a8b302c61235a29fef343a13c11d38bfbac8ea3
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
Size: 12831 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170727/4b93f156/attachment-0001.gz>
