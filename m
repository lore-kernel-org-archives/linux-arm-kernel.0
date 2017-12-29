From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 29 Dec 2017 15:12:39 +0800
Subject: [clk:clk-next 170/171] ERROR: "clk_regmap_mux_div_ops"
 [drivers/clk/qcom/apcs-msm8916.ko] undefined!
Message-ID: <201712291536.wObC6YtU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
head:   e717a189b1bc52a60f8c1177f277e4b6c2f0ae53
commit: 8a77f61118a2cb9bbe96d2a5cf912bce5bc03c13 [170/171] clk: qcom: Add APCS clock controller support
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        git checkout 8a77f61118a2cb9bbe96d2a5cf912bce5bc03c13
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   WARNING: modpost: missing MODULE_LICENSE() in drivers/auxdisplay/img-ascii-lcd.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/clk/qcom/a53-pll.o
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
   WARNING: modpost: missing MODULE_LICENSE() in drivers/staging/comedi/drivers/ni_atmio.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in net/9p/9pnet_xen.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in sound/soc/codecs/snd-soc-pcm512x-spi.o
   see include/linux/module.h for more information
>> ERROR: "clk_regmap_mux_div_ops" [drivers/clk/qcom/apcs-msm8916.ko] undefined!
>> ERROR: "__mux_div_set_src_div" [drivers/clk/qcom/apcs-msm8916.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62416 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171229/56eaa0a1/attachment-0001.gz>
