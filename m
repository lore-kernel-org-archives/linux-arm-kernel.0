From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 14 Nov 2016 18:32:02 +0100
Subject: [PATCH 0/2] ARM: da850: enable the MSTPRI and DDR2/mDDR drivers
Message-ID: <1479144724-14231-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a follow-up for my previous series:

  ARM: da850: new drivers for better LCDC support

from which the new drivers were merged, while the patch adding the
panel node was nacked and has been dropped.

The first patch in this series enables the new drivers in da850.dtsi.
It has been changed since the last iteration to not disable the added
nodes. Also: the patch enabling the nodes in da850-lcdk.dts has been
dropped too.

The second patch updates the davinci defconfig.

Bartosz Golaszewski (2):
  ARM: dts: da850: add the mstpri and ddrctl nodes
  ARM: davinci_all_defconfig: enable the mstpri and ddrctl drivers

 arch/arm/boot/dts/da850.dtsi           | 9 +++++++++
 arch/arm/configs/davinci_all_defconfig | 2 ++
 2 files changed, 11 insertions(+)

-- 
2.9.3
