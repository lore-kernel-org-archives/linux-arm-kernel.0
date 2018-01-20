From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 20 Jan 2018 12:52:34 +0800
Subject: [nomadik:gemini-ethernet-rtl8366rb 11/16] ERROR: "of_irq_count"
 [net/dsa/dsa_core.ko] undefined!
Message-ID: <201801201232.HtwAR2cV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-ethernet-rtl8366rb
head:   e79f5ccab09cd07654d73e9f0bf730a536cfc98a
commit: d88475d19900612b808775a73b3495e9b3598b26 [11/16] RFC: net/dsa: Allow DSA PHYs to define link IRQs
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        git checkout d88475d19900612b808775a73b3495e9b3598b26
        # save the attached .config to linux build tree
        make ARCH=x86_64 

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
   WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/soc_camera/soc_scale_crop.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/tegra-cec/tegra_cec.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/mtd/nand/denali_pci.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pxa/pinctrl-pxa2xx.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/power/reset/zx-reboot.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in net/9p/9pnet_xen.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in sound/soc/codecs/snd-soc-pcm512x-spi.o
   see include/linux/module.h for more information
>> ERROR: "of_irq_count" [net/dsa/dsa_core.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62413 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180120/5b06dd1f/attachment-0001.gz>
