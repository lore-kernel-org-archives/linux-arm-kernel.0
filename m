From: lkp@intel.com (kbuild test robot)
Date: Fri, 16 Nov 2018 23:24:32 +0800
Subject: [PATCH v4 3/4] ARM: dts: stm32: Add hwspinlock node for
 stm32mp157 SoC
In-Reply-To: <20181114090027.7580-4-benjamin.gaignard@linaro.org>
References: <20181114090027.7580-4-benjamin.gaignard@linaro.org>
Message-ID: <201811162325.9BhZeZhV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

I love your patch! Yet something to improve:

[auto build test ERROR on stm32/stm32-next]
[cannot apply to v4.20-rc2 next-20181116]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Benjamin-Gaignard/Add-support-of-STM32-hwspinlock/20181115-204402
base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/boot/dts/stm32mp157c-ed1.dtb: ERROR (duplicate_node_names): /soc/hwspinlock at 4c000000: Duplicate node name
>> ERROR: Input tree has errors, aborting (use -f to force output)
--
   arch/arm/boot/dts/stm32mp157c-ev1.dtb: ERROR (duplicate_node_names): /soc/hwspinlock at 4c000000: Duplicate node name
>> ERROR: Input tree has errors, aborting (use -f to force output)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 67811 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181116/03be4ccd/attachment-0001.gz>
