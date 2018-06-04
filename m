From: lkp@intel.com (kbuild test robot)
Date: Mon, 4 Jun 2018 22:57:30 +0800
Subject: [PATCH v5 4/4] ARM: dts: imx: add missing compatible and clock
 properties for EPIT
In-Reply-To: <20180604100035.19558-5-peron.clem@gmail.com>
References: <20180604100035.19558-5-peron.clem@gmail.com>
Message-ID: <201806042209.Muyb3cE5%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on v4.17 next-20180601]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Cl-ment-P-ron/Reintroduce-i-MX-EPIT-Timer/20180604-211036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-realview_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/imx6sl.dtsi:661.19-20 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 18007 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180604/87639177/attachment-0001.gz>
