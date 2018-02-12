From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 12 Feb 2018 15:42:34 +0800
Subject: [shawnguo:imx/dt 1/42] Error:
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts:19.1-2 syntax error
Message-ID: <201802121532.20rd85VM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git imx/dt
head:   4ce917f8d003453415200c6be13b74ba4676ddeb
commit: d287e28b2c909bf99a4aac5eb98521247b476517 [1/42] ARM: dts: ls1021a: add nodes for on-chip ram
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d287e28b2c909bf99a4aac5eb98521247b476517
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts:19.1-2 syntax error
>> FATAL ERROR: Unable to parse input tree
--
>> Error: arch/arm/boot/dts/ls1021a-qds.dts:51.1-2 syntax error
>> FATAL ERROR: Unable to parse input tree
--
>> Error: arch/arm/boot/dts/ls1021a-twr.dts:51.1-2 syntax error
>> FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23600 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180212/1c9342c6/attachment-0001.gz>
