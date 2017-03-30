From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 31 Mar 2017 06:59:06 +0800
Subject: [arm:sa1100 104/112] ERROR: "ipaq_micro_tx_msg"
 [arch/arm/mach-sa1100/h3xxx-sleeve.ko] undefined!
Message-ID: <201703310603.wstanCiK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git sa1100
head:   421be819b275def43bb042dfb9790025110cc784
commit: 724317514340b01db9235264e17abc59f4d50cc9 [104/112] ARM: sa1100/h3xxx: sleeve support
config: arm-simpad_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 724317514340b01db9235264e17abc59f4d50cc9
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
Size: 12813 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170331/f3cf6f67/attachment.gz>
