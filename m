From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 28 Nov 2017 06:59:13 +0800
Subject: [arm:hb2 14/25] arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi:44:10:
 fatal error: imx6qdl-microsom-ar8035.dtsi: No such file or directory
Message-ID: <201711280658.76jOj4p7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git hb2
head:   b5c9492ed71bd6042f856fb373e1302ade1c6e9e
commit: bc614467058bc326764484dd533f953a3ebaded8 [14/25] ARM: dts: imx6qdl: add HummingBoard2 boards
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout bc614467058bc326764484dd533f953a3ebaded8
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the arm/hb2 HEAD b5c9492ed71bd6042f856fb373e1302ade1c6e9e builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from arch/arm/boot/dts/imx6dl-hummingboard2.dts:47:0:
>> arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi:44:10: fatal error: imx6qdl-microsom-ar8035.dtsi: No such file or directory
    #include "imx6qdl-microsom-ar8035.dtsi"
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +44 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi

  > 44	#include "imx6qdl-microsom-ar8035.dtsi"
    45	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 42674 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/716a0bf7/attachment-0001.gz>
