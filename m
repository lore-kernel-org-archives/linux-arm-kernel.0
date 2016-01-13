From: lkp@intel.com (kbuild test robot)
Date: Wed, 13 Jan 2016 11:16:24 +0800
Subject: [PATCH 08/14] ARM: dts: imx6ul: add kpp support
In-Reply-To: <1452619291-13625-9-git-send-email-LW@KARO-electronics.de>
Message-ID: <201601131159.74prP1mB%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.4 next-20160112]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Lothar-Wa-mann/ARM-dts-imx6ul-add-more-functionality-to-i-MX6UL/20160113-012857
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/imx6ul.dtsi:380.21-22 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 54582 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160113/93326070/attachment-0001.obj>
