From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 2 Aug 2017 02:46:48 +0800
Subject: [rockchip:v4.14-armsoc/dts32 24/24] Error:
 arch/arm/boot/dts/rv1108.dtsi:166.18-19 syntax error
Message-ID: <201708020247.iHTNS8tt%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git v4.14-armsoc/dts32
head:   752db55c894e48ff08a89946604950071bed5f1e
commit: 752db55c894e48ff08a89946604950071bed5f1e [24/24] ARM: dts: rockchip: add watchdog dt node for rv1108
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 752db55c894e48ff08a89946604950071bed5f1e
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/rv1108.dtsi:166.18-19 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23094 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170802/bf4e156b/attachment-0001.gz>
