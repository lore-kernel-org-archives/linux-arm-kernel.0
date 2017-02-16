From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 16 Feb 2017 18:58:38 +0100
Subject: [PATCH 0/2] ARM: davinci_all_defconfig: enable modules required by
 vpif
Message-ID: <1487267920-3952-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch enables the modules needed for vpif display.

The second enables IRQ support for the pca953x driver needed for
correct vpif capture support on the da850-evm board with the UI
expander.

Bartosz Golaszewski (2):
  ARM: davinci_all_defconfig: enable VPIF display modules
  ARM: davinci_all_defconfig: enable IRQ support for pca953x

 arch/arm/configs/davinci_all_defconfig | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.9.3
