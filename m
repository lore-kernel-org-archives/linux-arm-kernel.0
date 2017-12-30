From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 30 Dec 2017 12:36:20 +0800
Subject: [arm:sa1100 56/106] drivers/pcmcia/max1600.c:122:16: error: expected
 declaration specifiers or '...' before string constant
Message-ID: <201712301216.si6srZ2W%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git sa1100
head:   22477d17bcf5f08b49d983300fee15c873e4977e
commit: c7aab28ac27ad6cd70dd78dba8c53c419ed72172 [56/106] ARM: pxa/mainstone: convert PCMCIA to use MAX1600 driver and gpiod APIs
config: arm-pxa_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c7aab28ac27ad6cd70dd78dba8c53c419ed72172
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> drivers/pcmcia/max1600.c:122:16: error: expected declaration specifiers or '...' before string constant
    MODULE_LICENSE("GPL v2");
                   ^~~~~~~~

vim +122 drivers/pcmcia/max1600.c

e35d50f0 Russell King 2016-08-31  121  
e35d50f0 Russell King 2016-08-31 @122  MODULE_LICENSE("GPL v2");

:::::: The code at line 122 was first introduced by commit
:::::: e35d50f09779d13ee4508924c802f847f6907710 pcmcia: add MAX1600 driver

:::::: TO: Russell King <rmk+kernel@armlinux.org.uk>
:::::: CC: Russell King <rmk+kernel@armlinux.org.uk>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32761 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171230/a7c07c28/attachment-0001.gz>
