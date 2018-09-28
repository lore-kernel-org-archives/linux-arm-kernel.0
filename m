From: vigneshr@ti.com (Vignesh R)
Date: Fri, 28 Sep 2018 10:55:57 +0530
Subject: [PATCH v2 2/2] i2c: busses: Kconfig: Enable I2C_OMAP for ARCH_K3
In-Reply-To: <20180928052557.21663-1-vigneshr@ti.com>
References: <20180928052557.21663-1-vigneshr@ti.com>
Message-ID: <20180928052557.21663-3-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow I2C_OMAP to be built for K3 platforms.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v2: No changes

 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 451d4ae50e66..ac4b09642f63 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -751,7 +751,7 @@ config I2C_OCORES
 
 config I2C_OMAP
 	tristate "OMAP I2C adapter"
-	depends on ARCH_OMAP
+	depends on ARCH_OMAP || ARCH_K3
 	default y if MACH_OMAP_H3 || MACH_OMAP_OSK
 	help
 	  If you say yes to this option, support will be included for the
-- 
2.19.0
