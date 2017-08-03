From: lkp@intel.com (kbuild test robot)
Date: Fri, 4 Aug 2017 05:28:40 +0800
Subject: [PATCH 2/2] arm64: dts: rockchip: Add support for rk3399
 excavator main board
In-Reply-To: <1501756357-10511-2-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <201708040551.mSxlH21s%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.13-rc3 next-20170803]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jacob-Chen/arm64-dts-rockchip-Add-support-for-rk3399-sapphire-SOM/20170804-002840
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi:197.1-6 Label or path hdmi not found
>> Error: arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi:632.1-6 Label or path vopb not found
>> Error: arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi:636.1-10 Label or path vopb_mmu not found
>> Error: arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi:640.1-6 Label or path vopl not found
>> Error: arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi:644.1-10 Label or path vopl_mmu not found
>> Error: arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts:157.1-5 Label or path edp not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 36243 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170804/8023003d/attachment-0001.gz>
