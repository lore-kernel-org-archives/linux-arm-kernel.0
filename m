From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 19 Nov 2012 15:46:32 +0100
Subject: [PATCH 0/4] ARM: dts: exynos4210-origen: Device tree fixes
Message-ID: <1353336396-21161-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes device tree support for Origen board:
 - memory is defined using sections of maximum allowed size
 - any pin configuration is modified to use pinctrl
 - invalid properties in sdhci nodes are replaced according to current
   mmc bindings
 - a fixed vmmc voltage regulator is added

Tested on Origen board.

Depends on:
[PATCH v2 0/2] mmc: host: sdhci-s3c: Add support for pinctrl interface

Tomasz Figa (4):
  ARM: dts: exynos4210-origen: Split memory sections
  ARM: dts: exynos4210-origen: Update for pinctrl-samsung driver
  ARM: dts: exynos4210-origen: Update sdhci nodes for current bindings
  ARM: dts: exynos4210-origen: Add vmmc fixed voltage regulator

 arch/arm/boot/dts/exynos4210-origen.dts | 54 ++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

-- 
1.8.0
