From: lkp@intel.com (kbuild test robot)
Date: Wed, 2 Nov 2016 13:28:20 +0800
Subject: [PATCH v2] ARM: at91/dt: add dts file for sama5d36ek CMP board
In-Reply-To: <1478055958-8463-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <201611021345.WcgqcfPD%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wenyou,

[auto build test ERROR on at91/at91-next]
[also build test ERROR on v4.9-rc3 next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Wenyou-Yang/ARM-at91-dt-add-dts-file-for-sama5d36ek-CMP-board/20161102-111152
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git at91-next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/sama5d3xmb_cmp.dtsi:143.17-18 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 21326 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161102/e70be8e1/attachment-0001.gz>
