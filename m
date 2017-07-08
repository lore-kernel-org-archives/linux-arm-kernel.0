From: lkp@intel.com (kbuild test robot)
Date: Sun, 9 Jul 2017 07:27:08 +0800
Subject: [PATCH] ARM: dts: at91: sama5d2_xplained: use pin macros instead
 of numbers
In-Reply-To: <20170707135611.10303-1-ludovic.desroches@microchip.com>
Message-ID: <201707090720.uyYcbj17%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic,

[auto build test ERROR on at91/at91-next]
[also build test ERROR on v4.12 next-20170707]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ludovic-Desroches/ARM-dts-at91-sama5d2_xplained-use-pin-macros-instead-of-numbers/20170709-040631
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git at91-next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/at91-sama5d2_xplained.dts:538.3-539.1 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22770 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170709/3da6f083/attachment-0001.gz>
