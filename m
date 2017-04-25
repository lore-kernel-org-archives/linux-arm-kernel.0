From: lkp@intel.com (kbuild test robot)
Date: Tue, 25 Apr 2017 11:56:55 +0800
Subject: [PATCH] ARM: dts: Add devicetree for the Raspberry Pi 3, for
 arm32 (v5)
In-Reply-To: <20170424200037.25615-1-eric@anholt.net>
Message-ID: <201704251135.5hOwV00O%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.11-rc8 next-20170424]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Eric-Anholt/ARM-dts-Add-devicetree-for-the-Raspberry-Pi-3-for-arm32-v5/20170425-063618
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> arch/arm/boot/dts/bcm2837-rpi-3.b.dts:1:46: fatal error: arm64/broadcom/bcm2837-rpi-3.b.dts: No such file or directory
    #include "arm64/broadcom/bcm2837-rpi-3.b.dts"
                                                 ^
   compilation terminated.

vim +1 arch/arm/boot/dts/bcm2837-rpi-3.b.dts

   > 1	#include "arm64/broadcom/bcm2837-rpi-3.b.dts"

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22403 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170425/f816bce5/attachment-0001.gz>
