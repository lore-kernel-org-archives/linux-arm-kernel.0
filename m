From: lkp@intel.com (kbuild test robot)
Date: Tue, 6 Nov 2018 20:07:23 +0800
Subject: [PATCH v4 2/3] media: meson: add v4l2 m2m video decoder driver
In-Reply-To: <20181106075926.19269-3-mjourdan@baylibre.com>
References: <20181106075926.19269-3-mjourdan@baylibre.com>
Message-ID: <201811062010.zqwrLaj3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linuxtv-media/master]
[also build test WARNING on v4.20-rc1 next-20181106]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Maxime-Jourdan/dt-bindings-media-add-Amlogic-Video-Decoder-Bindings/20181106-162646
base:   git://linuxtv.org/media_tree.git master


coccinelle warnings: (new ones prefixed by >>)

>> drivers/media/platform/meson/vdec/codec_mpeg12.c:149:2-3: Unneeded semicolon
--
>> drivers/media/platform/meson/vdec/vdec_helpers.c:187:3-4: Unneeded semicolon
--
>> drivers/media/platform/meson/vdec/esparser.c:148:13-31: WARNING: dma_zalloc_coherent should be used for eos_vaddr, instead of dma_alloc_coherent/memset

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
