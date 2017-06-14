From: lkp@intel.com (kbuild test robot)
Date: Wed, 14 Jun 2017 08:48:10 +0800
Subject: [PATCH v2 3/4] phy: usb: phy-brcm-usb: Add Broadcom STB USB phy
 driver
In-Reply-To: <1497365721-31188-4-git-send-email-al.cooper@broadcom.com>
Message-ID: <201706140818.8gkXWnCM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

[auto build test ERROR on phy/next]
[also build test ERROR on next-20170613]
[cannot apply to linus/master v4.12-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Al-Cooper/Add-Broadcom-STB-USB-phy-driver/20170614-070044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git next
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   ERROR: "ia64_delay_loop" [drivers/spi/spi-thunderx.ko] undefined!
>> ERROR: "brcmstb_get_family_id" [drivers/phy/broadcom/phy-brcm-usb-dvr.ko] undefined!
>> ERROR: "brcmstb_get_product_id" [drivers/phy/broadcom/phy-brcm-usb-dvr.ko] undefined!
   ERROR: "ia64_delay_loop" [drivers/net/phy/mdio-cavium.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47749 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170614/906c19ec/attachment-0001.gz>
