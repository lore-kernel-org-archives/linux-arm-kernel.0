From: lkp@intel.com (kbuild test robot)
Date: Sun, 15 Jan 2017 08:13:06 +0800
Subject: [PATCH v3] ARM: dts: Add LEGO MINDSTORMS EV3 dts
In-Reply-To: <1484253167-27568-1-git-send-email-david@lechnology.com>
Message-ID: <201701150836.H4TibehD%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.10-rc3 next-20170113]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/David-Lechner/ARM-dts-Add-LEGO-MINDSTORMS-EV3-dts/20170114-145113
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-u300_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/da850-lego-ev3.dts:310.1-6 Label or path usb1 not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 12462 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170115/a5b32497/attachment-0001.gz>
