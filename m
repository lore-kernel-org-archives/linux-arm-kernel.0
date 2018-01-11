From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 11 Jan 2018 09:00:08 +0800
Subject: [nomadik:gemini-ethernet 9/18] ERROR: "of_irq_count"
 [net/dsa/dsa_core.ko] undefined!
Message-ID: <201801110903.xKdnk3vl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-ethernet
head:   de0cb586c9e534c926cd7c74c92dc3d4104ea569
commit: 8ba4fbd39429b98be7df94669b332ac295b94b1a [9/18] RFC: net/dsa: Allow DSA PHYs to define link IRQs
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 8ba4fbd39429b98be7df94669b332ac295b94b1a
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   WARNING: modpost: missing MODULE_LICENSE() in drivers/auxdisplay/img-ascii-lcd.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-ath79.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-iop.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/accel/kxsd9-i2c.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/adc/qcom-vadc-common.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/mtk-vcodec/mtk-vcodec-common.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/tegra-cec/tegra_cec.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/mtd/nand/denali_pci.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pxa/pinctrl-pxa2xx.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/power/reset/zx-reboot.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/staging/comedi/drivers/ni_atmio.o
   see include/linux/module.h for more information
>> ERROR: "of_irq_count" [net/dsa/dsa_core.ko] undefined!
   ERROR: "ia64_delay_loop" [drivers/spi/spi-thunderx.ko] undefined!
   ERROR: "ia64_delay_loop" [drivers/net/phy/mdio-cavium.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49782 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180111/0939326a/attachment-0001.gz>
