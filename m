From: lkp@intel.com (kbuild test robot)
Date: Fri, 26 Feb 2016 06:54:29 +0800
Subject: [PATCH v2] ARM: dts: sun8i: Add leds and switch on Orangepi Plus
 boards
In-Reply-To: <20160225204234.GA31610@box2.japko.eu>
Message-ID: <201602260632.mOdfvVuL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.5-rc5 next-20160225]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Krzysztof-Adamski/ARM-dts-sun8i-Add-leds-and-switch-on-Orangepi-Plus-boards/20160226-044640
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm-sunxi_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts:104.1-7 Label or path r_pio not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 17442 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160226/de271787/attachment-0001.obj>
