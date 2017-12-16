From: lkp@intel.com (kbuild test robot)
Date: Sat, 16 Dec 2017 17:17:00 +0800
Subject: [PATCH 6/8] drm/sun4i: sun4i_layer: Wire in the frontend
In-Reply-To: <0cd2570c9cbe20d094cee0e8e9918c3a0f6af2fa.1513178989.git-series.maxime.ripard@free-electrons.com>
References: <0cd2570c9cbe20d094cee0e8e9918c3a0f6af2fa.1513178989.git-series.maxime.ripard@free-electrons.com>
Message-ID: <201712161652.Ef6bLzJu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

I love your patch! Yet something to improve:

[auto build test ERROR on ]

url:    https://github.com/0day-ci/linux/commits/Maxime-Ripard/drm-sun4i-Support-the-Display-Engine-frontend/20171216-122702
base:    
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   WARNING: modpost: missing MODULE_LICENSE() in arch/arm/common/bL_switcher_dummy_if.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/auxdisplay/img-ascii-lcd.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/cpufreq/mediatek-cpufreq.o
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
   WARNING: modpost: missing MODULE_LICENSE() in drivers/mmc/host/renesas_sdhi_core.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/mtd/nand/denali_pci.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/net/ethernet/cirrus/cs89x0.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/phy/qualcomm/phy-qcom-ufs.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pxa/pinctrl-pxa2xx.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/power/reset/zx-reboot.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/soc/qcom/rmtfs_mem.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/staging/comedi/drivers/ni_atmio.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/mmp/mmp_disp.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in sound/soc/codecs/snd-soc-pcm512x-spi.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-mach-mop500.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-plat-dma.o
   see include/linux/module.h for more information
>> ERROR: "sun4i_frontend_update_formats" [drivers/gpu/drm/sun4i/sun4i-backend.ko] undefined!
>> ERROR: "sun4i_frontend_update_buffer" [drivers/gpu/drm/sun4i/sun4i-backend.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64661 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171216/9eb1088e/attachment-0001.gz>
