From: lkp@intel.com (kbuild test robot)
Date: Wed, 9 Nov 2016 04:34:08 +0800
Subject: [PATCH 3/3] ARM: dts: da850: add usb device node
In-Reply-To: <20161108185831.17683-4-ahaslam@baylibre.com>
Message-ID: <201611090424.k0rxEr1y%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Axel,

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on next-20161108]
[cannot apply to robh/for-next v4.9-rc4]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Axel-Haslam/USB-ohci-da8xx-Add-devicetree-bindings/20161109-031338
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/da850-lcdk.dts:89.1-9 Label or path usb_phy not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 21781 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161109/5e5ea637/attachment-0001.gz>
