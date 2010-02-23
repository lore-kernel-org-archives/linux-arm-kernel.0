From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 23 Feb 2010 15:42:59 +0530
Subject: [PATCH 1/4] ux500: fix CLKRST addresses
In-Reply-To: <1266919983-32759-1-git-send-email-rabin.vincent@stericsson.com>
References: <1266919983-32759-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1266919983-32759-2-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct the base addresses of the CLKRST registers.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/include/mach/hardware.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index 6da6502..04ea836 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -68,12 +68,12 @@
 #define U8500_PKAM_BASE		(U8500_PER6_BASE + 0x2000)
 #define U8500_CRYPTO0_BASE	(U8500_PER6_BASE + 0xa000)
 #define U8500_CRYPTO1_BASE	(U8500_PER6_BASE + 0xb000)
-#define U8500_CLKRST6_BASE	(U8500_PER7_BASE + 0xf000)
+#define U8500_CLKRST6_BASE	(U8500_PER6_BASE + 0xf000)
 
 /* per5 base addressess */
 #define U8500_USBOTG_BASE	(U8500_PER5_BASE + 0x00000)
 #define U8500_GPIO5_BASE	(U8500_PER5_BASE + 0x1e000)
-#define U8500_CLKRST5_BASE	(U8500_PER7_BASE + 0x1f000)
+#define U8500_CLKRST5_BASE	(U8500_PER5_BASE + 0x1f000)
 
 /* per4 base addressess */
 #define U8500_BACKUPRAM0_BASE	(U8500_PER4_BASE + 0x0000)
@@ -95,7 +95,7 @@
 #define U8500_UART2_BASE	(U8500_PER3_BASE + 0x7000)
 #define U8500_SDI5_BASE		(U8500_PER3_BASE + 0x8000)
 #define U8500_GPIO3_BASE	(U8500_PER3_BASE + 0xe000)
-#define U8500_CLKRST3_BASE	(U8500_PER7_BASE + 0xf000)
+#define U8500_CLKRST3_BASE	(U8500_PER3_BASE + 0xf000)
 
 /* per2 base addressess */
 #define U8500_I2C3_BASE		(U8500_PER2_BASE + 0x0000)
@@ -123,7 +123,7 @@
 #define U8500_SPI3_BASE		(U8500_PER1_BASE + 0x9000)
 #define U8500_SLIM0_BASE	(U8500_PER1_BASE + 0xa000)
 #define U8500_GPIO1_BASE	(U8500_PER1_BASE + 0xe000)
-#define U8500_CLKRST1_BASE	(U8500_PER2_BASE + 0xf000)
+#define U8500_CLKRST1_BASE	(U8500_PER1_BASE + 0xf000)
 
 /* ST-Ericsson modified pl022 id */
 #define SSP_PER_ID		0x01080022
-- 
1.7.0
