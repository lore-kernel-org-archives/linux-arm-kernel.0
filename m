From: vigneshr@ti.com (Vignesh R)
Date: Wed, 7 Nov 2018 16:09:24 +0530
Subject: [PATCH 0/2] McSPI: Enable mcspi driver for AM654 SoCs
Message-ID: <20181107103926.32550-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Couple of patches to enable mcspi driver to be used with TI's new
AM654 SoCs.

Vignesh R (2):
  dt-bindings: spi: omap-spi: Add compatible for AM654 SoC
  spi: Kconfig: Enable McSPI driver for K3 platforms

 Documentation/devicetree/bindings/spi/omap-spi.txt | 1 +
 drivers/spi/Kconfig                                | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.19.1
