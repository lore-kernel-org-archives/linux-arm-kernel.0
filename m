From: prakity@marvell.com (Philip Rakity)
Date: Fri, 22 Apr 2011 13:16:14 -0700
Subject: [PATCH] plat-pxa: add missing define for PERMANENT CARDS 
Message-ID: <7AB22AD5-15A5-42CC-9041-FA71603A5238@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/include/plat/sdhci.h
index b3e4d19..1c655d0 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -17,6 +17,7 @@
 /* Require clock free running */
 
 /* Board design supports 8-bit data on SD/SDIO BUS */
+#define PXA_FLAG_CARD_PERMANENT		(1<<1)
 #define PXA_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2)
 
 /*
-- 
1.7.0.4
