From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 28 Jan 2010 20:50:39 +0100
Subject: [PATCH] mx35: add a missing comma in a pad definition
Message-ID: <1264708239-12219-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Tim Sander <tstone@vlsi.informatik.tu-darmstadt.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/iomux-mx35.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx35.h b/arch/arm/plat-mxc/include/mach/iomux-mx35.h
index 00b0ac1..c88d407 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx35.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx35.h
@@ -671,7 +671,7 @@
 #define MX35_PAD_LD8__SDMA_SDMA_DEBUG_PC_8			IOMUX_PAD(0x634, 0x1d0, 6, 0x0,   0, NO_PAD_CTRL)
 
 #define MX35_PAD_LD9__IPU_DISPB_DAT_9				IOMUX_PAD(0x638, 0x1d4, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX35_PAD_LD9__GPIO2_9					IOMUX_PAD(0x638, 0x1d4, 5, 0x8e4  0, NO_PAD_CTRL)
+#define MX35_PAD_LD9__GPIO2_9					IOMUX_PAD(0x638, 0x1d4, 5, 0x8e4, 0, NO_PAD_CTRL)
 #define MX35_PAD_LD9__SDMA_SDMA_DEBUG_PC_9			IOMUX_PAD(0x638, 0x1d4, 6, 0x0,   0, NO_PAD_CTRL)
 
 #define MX35_PAD_LD10__IPU_DISPB_DAT_10				IOMUX_PAD(0x63c, 0x1d8, 0, 0x0,   0, NO_PAD_CTRL)
-- 
1.6.6
