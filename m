From: lkp@intel.com (kbuild test robot)
Date: Fri, 29 Jun 2018 17:51:50 +0800
Subject: [PATCH 2/2] reset: uniphier: add USB3 controller reset control
In-Reply-To: <1530259891-18822-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1530259891-18822-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <201806291748.vJuFn1CE%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kunihiko,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pza/reset/next]
[also build test ERROR on v4.18-rc2 next-20180628]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kunihiko-Hayashi/reset-uniphier-add-USB3-controller-reset-support/20180629-162836
base:   git://git.pengutronix.de/git/pza/linux reset/next
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   ERROR: "ia64_delay_loop" [drivers/spi/spi-thunderx.ko] undefined!
>> ERROR: "reset_simple_ops" [drivers/reset/reset-uniphier-usb3.ko] undefined!
   ERROR: "__sw_hweight8" [drivers/net/wireless/mediatek/mt76/mt76.ko] undefined!
   ERROR: "ia64_delay_loop" [drivers/net/phy/mdio-cavium.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49877 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180629/5fb3c9a9/attachment-0001.gz>
