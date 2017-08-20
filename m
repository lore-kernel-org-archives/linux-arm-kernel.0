From: lkp@intel.com (kbuild test robot)
Date: Sun, 20 Aug 2017 08:59:16 +0800
Subject: [PATCH] ARM: sun8i: a83t: Add device tree for Sinovoip Bananapi
 BPI-M3
In-Reply-To: <20170817034048.11601-1-wens@csie.org>
Message-ID: <201708200827.WQojuopU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.13-rc5 next-20170817]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chen-Yu-Tsai/ARM-sun8i-a83t-Add-device-tree-for-Sinovoip-Bananapi-BPI-M3/20170820-055904
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts:64.1-7 Label or path ehci0 not found
>> Error: arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts:71.1-6 Label or path mmc0 not found
>> Error: arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts:81.1-6 Label or path mmc2 not found
>> Error: arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts:91.1-7 Label or path r_rsb not found
>> Error: arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts:145.1-8 Label or path usbphy not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23091 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170820/1bad2dca/attachment-0001.gz>
