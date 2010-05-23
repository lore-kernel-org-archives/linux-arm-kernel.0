From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sun, 23 May 2010 21:55:46 +0200
Subject: [PATCH 137/199] arch/arm/mach-sa1100/leds.c: Checkpatch cleanup
In-Reply-To: <1274644549-24952-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644549-24952-1-git-send-email-andrea.gelmini@gelma.net>
Message-ID: <1274644549-24952-10-git-send-email-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-sa1100/leds.c:21: ERROR: code indent should use tabs where possible
arch/arm/mach-sa1100/leds.c:21: WARNING: please, no space before tabs
arch/arm/mach-sa1100/leds.c:22: ERROR: code indent should use tabs where possible
arch/arm/mach-sa1100/leds.c:22: WARNING: please, no space before tabs
arch/arm/mach-sa1100/leds.c:24: ERROR: code indent should use tabs where possible
arch/arm/mach-sa1100/leds.c:24: WARNING: please, no space before tabs

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-sa1100/leds.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-sa1100/leds.c b/arch/arm/mach-sa1100/leds.c
index 4cf7c56..bbfe197 100644
--- a/arch/arm/mach-sa1100/leds.c
+++ b/arch/arm/mach-sa1100/leds.c
@@ -2,7 +2,7 @@
  * linux/arch/arm/mach-sa1100/leds.c
  *
  * SA1100 LEDs dispatcher
- * 
+ *
  * Copyright (C) 2001 Nicolas Pitre
  */
 #include <linux/compiler.h>
@@ -18,10 +18,10 @@ sa1100_leds_init(void)
 {
 	if (machine_is_assabet())
 		leds_event = assabet_leds_event;
- 	if (machine_is_consus())
- 	        leds_event = consus_leds_event;
+	if (machine_is_consus())
+		leds_event = consus_leds_event;
 	if (machine_is_badge4())
-	  	leds_event = badge4_leds_event;
+		leds_event = badge4_leds_event;
 	if (machine_is_brutus())
 		leds_event = brutus_leds_event;
 	if (machine_is_cerf())
-- 
1.7.1.251.gf80a2
