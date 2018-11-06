From: lkp@intel.com (kbuild test robot)
Date: Tue, 6 Nov 2018 19:26:55 +0800
Subject: [PATCH v4 2/3] media: meson: add v4l2 m2m video decoder driver
In-Reply-To: <20181106075926.19269-3-mjourdan@baylibre.com>
References: <20181106075926.19269-3-mjourdan@baylibre.com>
Message-ID: <201811061950.x1Ixrlth%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.20-rc1 next-20181106]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Maxime-Jourdan/dt-bindings-media-add-Amlogic-Video-Decoder-Bindings/20181106-162646
base:   git://linuxtv.org/media_tree.git master
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   ERROR: "ia64_delay_loop" [drivers/spi/spi-thunderx.ko] undefined!
   ERROR: "numa_slit" [drivers/nvme/host/nvme-core.ko] undefined!
   ERROR: "__sw_hweight8" [drivers/net/wireless/mediatek/mt76/mt76.ko] undefined!
   ERROR: "ia64_delay_loop" [drivers/net/phy/mdio-cavium.ko] undefined!
>> ERROR: "meson_canvas_get" [drivers/media/platform/meson/vdec/meson-vdec.ko] undefined!
>> ERROR: "meson_canvas_alloc" [drivers/media/platform/meson/vdec/meson-vdec.ko] undefined!
>> ERROR: "meson_canvas_config" [drivers/media/platform/meson/vdec/meson-vdec.ko] undefined!
>> ERROR: "meson_canvas_free" [drivers/media/platform/meson/vdec/meson-vdec.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52270 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181106/890c0aeb/attachment-0001.gz>
