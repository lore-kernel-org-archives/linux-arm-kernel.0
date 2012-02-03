From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:31:48 +0000
Subject: [PATCH 02/17] ARM: sa11x0: assabet: deassert QMUTE to codec while
 codec is unpowered
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOrM-0001Bd-D5@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 642f3b3..3a3282e 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -40,13 +40,13 @@
 #include "generic.h"
 
 #define ASSABET_BCR_DB1110 \
-	(ASSABET_BCR_SPK_OFF    | ASSABET_BCR_QMUTE     | \
+	(ASSABET_BCR_SPK_OFF    | \
 	 ASSABET_BCR_LED_GREEN  | ASSABET_BCR_LED_RED   | \
 	 ASSABET_BCR_RS232EN    | ASSABET_BCR_LCD_12RGB | \
 	 ASSABET_BCR_IRDA_MD0)
 
 #define ASSABET_BCR_DB1111 \
-	(ASSABET_BCR_SPK_OFF    | ASSABET_BCR_QMUTE     | \
+	(ASSABET_BCR_SPK_OFF    | \
 	 ASSABET_BCR_LED_GREEN  | ASSABET_BCR_LED_RED   | \
 	 ASSABET_BCR_RS232EN    | ASSABET_BCR_LCD_12RGB | \
 	 ASSABET_BCR_CF_BUS_OFF | ASSABET_BCR_STEREO_LB | \
-- 
1.7.4.4
