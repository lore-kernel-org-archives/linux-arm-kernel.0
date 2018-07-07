From: lkp@intel.com (kbuild test robot)
Date: Sat, 7 Jul 2018 18:36:16 +0800
Subject: [rockchip:v4.19-armsoc/dts64 7/11] Error:
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi:263.1-7 Label or
 path sound not found
Message-ID: <201807071814.GP4WAby3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git v4.19-armsoc/dts64
head:   70c7ee25836e3d90f6b9b728db35ad3ff8f64c2d
commit: eedeeb7b76ccd4a5a546c924c0dcf93d560670fd [7/11] arm64: dts: rockchip: move Chromebook-specific Gru-parts to a separate file
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout eedeeb7b76ccd4a5a546c924c0dcf93d560670fd
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

Note: the rockchip/v4.19-armsoc/dts64 HEAD 70c7ee25836e3d90f6b9b728db35ad3ff8f64c2d builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi:263.1-7 Label or path sound not found
>> Error: arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi:355.1-6 Label or path wifi not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38743 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180707/b5f3c0d6/attachment-0001.gz>
