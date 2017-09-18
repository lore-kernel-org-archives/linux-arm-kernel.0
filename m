From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 19 Sep 2017 05:39:47 +0800
Subject: [nomadik:gemini-dir-685-pinctrl-flashswap 2/2] Error:
 arch/arm/boot/dts/gemini-sq201.dts:10.1-2 syntax error
Message-ID: <201709190544.1JzB6SAj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-dir-685-pinctrl-flashswap
head:   3623f5e7196c4ccbf66047102b9375f73f5749d2
commit: 3623f5e7196c4ccbf66047102b9375f73f5749d2 [2/2] flash hack
config: arm-omap2plus_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 3623f5e7196c4ccbf66047102b9375f73f5749d2
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/gemini-sq201.dts:10.1-2 syntax error
   FATAL ERROR: Unable to parse input tree
--
>> Error: arch/arm/boot/dts/gemini-rut1xx.dts:10.1-2 syntax error
   FATAL ERROR: Unable to parse input tree
--
>> Error: arch/arm/boot/dts/gemini-wbd111.dts:10.1-2 syntax error
   FATAL ERROR: Unable to parse input tree
--
>> Error: arch/arm/boot/dts/gemini-nas4220b.dts:10.1-2 syntax error
   FATAL ERROR: Unable to parse input tree
--
>> Error: arch/arm/boot/dts/gemini-dlink-dir-685.dts:10.1-2 syntax error
   FATAL ERROR: Unable to parse input tree
--
>> Error: arch/arm/boot/dts/gemini-wbd222.dts:10.1-2 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30142 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170919/2da14b1c/attachment-0001.gz>
