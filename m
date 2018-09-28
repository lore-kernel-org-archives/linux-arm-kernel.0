From: vigneshr@ti.com (Vignesh R)
Date: Fri, 28 Sep 2018 10:55:55 +0530
Subject: [PATCH v2 0/2] i2c-omap: Enable i2c-omap driver for AM654 SoCs
Message-ID: <20180928052557.21663-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Couple of patches to enable i2c-omap driver to be used with TI's new
AM654 platforms.


Vignesh R (2):
  dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
  i2c: busses: Kconfig: Enable I2C_OMAP for ARCH_K3

 Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
 drivers/i2c/busses/Kconfig                         | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.19.0
