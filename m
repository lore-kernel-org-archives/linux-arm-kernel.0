From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 6 Jun 2017 02:46:40 +0800
Subject: [arm:sa1100 107/115] ERROR: "ipaq_micro_tx_msg"
 [arch/arm/mach-sa1100/h3xxx-sleeve.ko] undefined!
Message-ID: <201706060229.uvEA67Fn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git sa1100
head:   ec0665bd174b0f3d3fd1a59f4b3d45e4d10c47f8
commit: 01dfb59160fbf2d8d98ad7ba129fa8e611202ee0 [107/115] ARM: sa1100/h3xxx: sleeve support
config: arm-neponset_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 01dfb59160fbf2d8d98ad7ba129fa8e611202ee0
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
Size: 16062 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170606/30485141/attachment.gz>
