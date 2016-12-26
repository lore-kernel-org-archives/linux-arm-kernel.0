From: lkp@intel.com (kbuild test robot)
Date: Tue, 27 Dec 2016 03:34:29 +0800
Subject: [PATCH v2] ARM: dts: sunxi: Add num-cs for A20 spi nodes
In-Reply-To: <20161226174748.17544-1-manu@bidouilliste.com>
Message-ID: <201612270319.Q2vQftLu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emmanuel,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.10-rc1 next-20161224]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Emmanuel-Vadot/ARM-dts-sunxi-Add-num-cs-for-A20-spi-nodes/20161227-015214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/sun7i-a20.dtsi:874.13-14 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 21781 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161227/708b3bf8/attachment-0001.gz>
