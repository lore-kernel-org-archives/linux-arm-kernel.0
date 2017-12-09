From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 9 Dec 2017 19:02:23 +0800
Subject: [clk:clk-next 32/61] ERROR: "clk_alpha_pll_regs"
 [drivers/clk/qcom/mmcc-msm8996.ko] undefined!
Message-ID: <201712091823.k2owsodq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
head:   3279e463717f719f7dc16c9fc39fb0bad43b574e
commit: d1506b749e92056b72d9b93f606adb6a4f229ac2 [32/61] clk: qcom: support for alpha pll properties
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        git checkout d1506b749e92056b72d9b93f606adb6a4f229ac2
        # save the attached .config to linux build tree
        make ARCH=i386 

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
   WARNING: modpost: missing MODULE_LICENSE() in drivers/net/ethernet/cirrus/cs89x0.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pxa/pinctrl-pxa2xx.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/power/reset/zx-reboot.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/staging/comedi/drivers/ni_atmio.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in sound/soc/codecs/snd-soc-pcm512x-spi.o
   see include/linux/module.h for more information
>> ERROR: "clk_alpha_pll_regs" [drivers/clk/qcom/mmcc-msm8996.ko] undefined!
>> ERROR: "clk_alpha_pll_regs" [drivers/clk/qcom/gcc-msm8996.ko] undefined!
>> ERROR: "clk_alpha_pll_regs" [drivers/clk/qcom/gcc-msm8994.ko] undefined!
>> ERROR: "clk_alpha_pll_regs" [drivers/clk/qcom/gcc-ipq8074.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62438 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171209/52ffaf6d/attachment-0001.gz>
