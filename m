From: lkp@intel.com (kbuild test robot)
Date: Sun, 23 Jul 2017 08:36:13 +0800
Subject: [PATCH v2 07/10] ARM: dts: sun8i: a83t: Add MMC controller
 device nodes
In-Reply-To: <20170720034452.15920-8-wens@csie.org>
Message-ID: <201707230832.hsaOQVRK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

[auto build test ERROR on next-20170719]
[cannot apply to clk/clk-next robh/for-next linus/master v4.13-rc1 v4.12 v4.12-rc7 v4.13-rc1]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chen-Yu-Tsai/ARM-sun8i-a83t-Add-support-for-MMC-controllers/20170723-054406
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/sun8i-a83t.dtsi:187.19-20 syntax error
>> FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23057 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170723/77ae89c1/attachment-0001.gz>
