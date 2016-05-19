From: vigneshr@ti.com (Vignesh R)
Date: Thu, 19 May 2016 12:17:28 +0530
Subject: [PATCH 0/2] AM335x ICE: Add support for PCA9536 GPIO expander
Message-ID: <1463640450-16762-1-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



This patch series adds support for TI PCA9536 GPIO expander present on
AM335x ICE board.

Vignesh R (2):
  gpio: pca953x: Add support for TI PCA9536
  ARM: dts: am335x-icev2: Add DT node for TI PCA9536

 Documentation/devicetree/bindings/gpio/gpio-pca953x.txt | 1 +
 arch/arm/boot/dts/am335x-icev2.dts                      | 7 +++++++
 drivers/gpio/gpio-pca953x.c                             | 1 +
 3 files changed, 9 insertions(+)

-- 
2.8.2
