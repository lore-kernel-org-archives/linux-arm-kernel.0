From: lkp@intel.com (kbuild test robot)
Date: Mon, 22 May 2017 19:14:13 +0800
Subject: [PATCH v2 3/5] ARM: dts: stm32: enable CRC32 on stm32429-disco
 board
In-Reply-To: <d042019ac4871cc8cacd2cea04b7933feb96dda8.1495285223.git.cosardindar@gmail.com>
Message-ID: <201705221955.jjTOXBxu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cosar,

[auto build test ERROR on cryptodev/master]
[also build test ERROR on v4.12-rc2 next-20170522]
[cannot apply to robh/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Cosar-Dindar/Add-support-for-the-STM32F4-CRC32/20170522-151254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/Cosar-Dindar/Add-support-for-the-STM32F4-CRC32/20170522-151254 HEAD 6822bdfe94793c70fe6812817f26f02db23e2593 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/stm32f429-disco.dts:105.1-5 Label or path crc not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22761 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170522/b0aa82de/attachment-0001.gz>
