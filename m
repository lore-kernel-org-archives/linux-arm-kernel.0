From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 12 Jul 2017 00:27:27 +0800
Subject: [nomadik:gemini-dir-685-pinctrl-flashswap 19/19] Error:
 arch/arm/boot/dts/gemini-wbd222.dts:10.1-2 syntax error
Message-ID: <201707120025.pfl2XSIq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-dir-685-pinctrl-flashswap
head:   247336f3769b813b799feaead236d350f0da51ff
commit: 247336f3769b813b799feaead236d350f0da51ff [19/19] flash hack
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 247336f3769b813b799feaead236d350f0da51ff
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/gemini-wbd222.dts:10.1-2 syntax error
   FATAL ERROR: Unable to parse input tree
--
>> Error: arch/arm/boot/dts/gemini-nas4220b.dts:10.1-2 syntax error
   FATAL ERROR: Unable to parse input tree
--
>> Error: arch/arm/boot/dts/gemini-sq201.dts:10.1-2 syntax error
   FATAL ERROR: Unable to parse input tree
--
>> Error: arch/arm/boot/dts/gemini-rut1xx.dts:10.1-2 syntax error
   FATAL ERROR: Unable to parse input tree
--
>> Error: arch/arm/boot/dts/gemini-wbd111.dts:10.1-2 syntax error
   FATAL ERROR: Unable to parse input tree
--
>> Error: arch/arm/boot/dts/gemini-dlink-dir-685.dts:10.1-2 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23021 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170712/12000934/attachment-0001.gz>
