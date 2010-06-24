From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 24 Jun 2010 16:02:11 +0200
Subject: [PATCH 3/4] ARM/scoop: Add CPR register bit definitions
In-Reply-To: <1277388132-5549-1-git-send-email-marek.vasut@gmail.com>
References: <1277388132-5549-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1277388132-5549-3-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bit definitions of the CPR register of the SCOOP chip into scoop.h. Also,
cleanup the GPCR definitions to match coding style.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/include/asm/hardware/scoop.h |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/hardware/scoop.h b/arch/arm/include/asm/hardware/scoop.h
index 46492a6..ebb3cea 100644
--- a/arch/arm/include/asm/hardware/scoop.h
+++ b/arch/arm/include/asm/hardware/scoop.h
@@ -22,18 +22,23 @@
 #define SCOOP_GPWR 0x24
 #define SCOOP_GPRR 0x28
 
-#define SCOOP_GPCR_PA22	( 1 << 12 )
-#define SCOOP_GPCR_PA21	( 1 << 11 )
-#define SCOOP_GPCR_PA20	( 1 << 10 )
-#define SCOOP_GPCR_PA19	( 1 << 9 )
-#define SCOOP_GPCR_PA18	( 1 << 8 )
-#define SCOOP_GPCR_PA17	( 1 << 7 )
-#define SCOOP_GPCR_PA16	( 1 << 6 )
-#define SCOOP_GPCR_PA15	( 1 << 5 )
-#define SCOOP_GPCR_PA14	( 1 << 4 )
-#define SCOOP_GPCR_PA13	( 1 << 3 )
-#define SCOOP_GPCR_PA12	( 1 << 2 )
-#define SCOOP_GPCR_PA11	( 1 << 1 )
+#define SCOOP_CPR_OUT	(1 << 7)
+#define SCOOP_CPR_SD_3V	(1 << 2)
+#define SCOOP_CPR_CF_XV	(1 << 1)
+#define SCOOP_CPR_CF_3V	(1 << 0)
+
+#define SCOOP_GPCR_PA22	(1 << 12)
+#define SCOOP_GPCR_PA21	(1 << 11)
+#define SCOOP_GPCR_PA20	(1 << 10)
+#define SCOOP_GPCR_PA19	(1 << 9)
+#define SCOOP_GPCR_PA18	(1 << 8)
+#define SCOOP_GPCR_PA17	(1 << 7)
+#define SCOOP_GPCR_PA16	(1 << 6)
+#define SCOOP_GPCR_PA15	(1 << 5)
+#define SCOOP_GPCR_PA14	(1 << 4)
+#define SCOOP_GPCR_PA13	(1 << 3)
+#define SCOOP_GPCR_PA12	(1 << 2)
+#define SCOOP_GPCR_PA11	(1 << 1)
 
 struct scoop_config {
 	unsigned short io_out;
-- 
1.7.1
