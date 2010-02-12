From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Feb 2010 16:51:47 -0800
Subject: [PATCH 17/19] OMAP4: IRQ: Add McPDM IRQ definition
In-Reply-To: <20100212004844.24958.29506.stgit@baageli.muru.com>
References: <20100212004844.24958.29506.stgit@baageli.muru.com>
Message-ID: <20100212005147.24958.17099.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorge Eduardo Candelaria <x0107209@ti.com>

Support for McPDM IRQs in OMAP4

Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/irqs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 90d8370..e8205c1 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -442,7 +442,7 @@
 #define INT_44XX_PARTHASH_IRQ	(79 + IRQ_GIC_START)
 #define INT_44XX_MMC3_IRQ	(94 + IRQ_GIC_START)
 #define INT_44XX_MMC4_IRQ	(96 + IRQ_GIC_START)
-
+#define INT_44XX_MCPDM_IRQ	(112 + IRQ_GIC_START)
 
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730/850) and
  * 16 MPUIO lines */
