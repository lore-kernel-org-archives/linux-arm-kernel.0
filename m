From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Dec 2009 15:52:53 -0800
Subject: [PATCH 03/14] omap: Correcting GPMC_CONFIG1_DEVICETYPE_NAND
In-Reply-To: <20091211234919.3189.95607.stgit@localhost>
References: <20091211234919.3189.95607.stgit@localhost>
Message-ID: <20091211235253.3189.70764.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vimal Singh <vimalsingh@ti.com>

For NAND devices '2' should be used with GPMC_CONFIG1_DEVICETYPE
instead of '1'.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/gpmc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 696e0ca..e081338 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -45,7 +45,7 @@
 #define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
 #define GPMC_CONFIG1_DEVICETYPE(val)    ((val & 3) << 10)
 #define GPMC_CONFIG1_DEVICETYPE_NOR     GPMC_CONFIG1_DEVICETYPE(0)
-#define GPMC_CONFIG1_DEVICETYPE_NAND    GPMC_CONFIG1_DEVICETYPE(1)
+#define GPMC_CONFIG1_DEVICETYPE_NAND    GPMC_CONFIG1_DEVICETYPE(2)
 #define GPMC_CONFIG1_MUXADDDATA         (1 << 9)
 #define GPMC_CONFIG1_TIME_PARA_GRAN     (1 << 4)
 #define GPMC_CONFIG1_FCLK_DIV(val)      (val & 3)
