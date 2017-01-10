From: lkp@intel.com (kbuild test robot)
Date: Tue, 10 Jan 2017 21:37:44 +0800
Subject: [PATCH 3/3] arm64: dts: add BananaPi-M64 support
In-Reply-To: <1484011353-21480-4-git-send-email-andre.przywara@arm.com>
Message-ID: <201701102144.8Ei2s459%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

[auto build test ERROR on mripard/sunxi/for-next]
[also build test ERROR on next-20170110]
[cannot apply to robh/for-next v4.10-rc3]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andre-Przywara/arm64-dts-A64-board-MMC-support/20170110-124554
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git sunxi/for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts:80.1-6 Label or path mmc0 not found
>> Error: arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts:91.1-6 Label or path mmc1 not found
>> Error: arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts:100.1-6 Label or path mmc2 not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33694 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170110/903bf854/attachment-0001.gz>
