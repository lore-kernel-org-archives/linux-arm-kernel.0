From: lkp@intel.com (kbuild test robot)
Date: Wed, 9 Aug 2017 06:39:47 +0800
Subject: [PATCH 2/2] arm64: dts: move rpi into rpi directory
In-Reply-To: <1500483950-9217-3-git-send-email-scott.branden@broadcom.com>
Message-ID: <201708090619.AOiafigN%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

[auto build test ERROR on v4.13-rc1]
[cannot apply to robh/for-next arm64/for-next/core next-20170808]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Scott-Branden/arm64-dts-move-ns2-into-northstar2-directory/20170721-023618
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> arch/arm/boot/dts/bcm2837-rpi-3-b.dts:1:46: fatal error: arm64/broadcom/bcm2837-rpi-3-b.dts: No such file or directory
    #include "arm64/broadcom/bcm2837-rpi-3-b.dts"
                                                 ^
   compilation terminated.

vim +1 arch/arm/boot/dts/bcm2837-rpi-3-b.dts

072f58af Eric Anholt 2017-04-25 @1  #include "arm64/broadcom/bcm2837-rpi-3-b.dts"

:::::: The code at line 1 was first introduced by commit
:::::: 072f58af1dfbc39f8daf6be170d90c2465df4771 ARM: dts: Add devicetree for the Raspberry Pi 3, for arm32 (v6)

:::::: TO: Eric Anholt <eric@anholt.net>
:::::: CC: Eric Anholt <eric@anholt.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23094 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170809/de59c3ef/attachment-0001.gz>
