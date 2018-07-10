From: lkp@intel.com (kbuild test robot)
Date: Tue, 10 Jul 2018 20:06:50 +0800
Subject: [PATCH 1/2] clk: imx: add ocram_s clock for i.mx6sx
In-Reply-To: <1531211979-2179-1-git-send-email-Anson.Huang@nxp.com>
References: <1531211979-2179-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <201807101933.aFKUdqqV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on v4.18-rc4 next-20180709]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Anson-Huang/clk-imx-add-ocram_s-clock-for-i-mx6sx/20180710-171526
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-omap2plus_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   In file included from arch/arm/boot/dts/imx6sx.dtsi:5:0,
                    from arch/arm/boot/dts/imx6sx-nitrogen6sx.dts:44:
>> scripts/dtc/include-prefixes/dt-bindings/clock/imx6sx-clock.h:282:0: warning: "IMX6SX_CLK_OCRAM_S" redefined
    #define IMX6SX_CLK_OCRAM_S  269
    
   scripts/dtc/include-prefixes/dt-bindings/clock/imx6sx-clock.h:170:0: note: this is the location of the previous definition
    #define IMX6SX_CLK_OCRAM_S  157
    

vim +/IMX6SX_CLK_OCRAM_S +282 scripts/dtc/include-prefixes/dt-bindings/clock/imx6sx-clock.h

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33963 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/68736bd2/attachment-0001.gz>
