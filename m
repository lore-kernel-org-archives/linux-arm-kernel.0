From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sun, 23 May 2010 22:09:58 +0200
Subject: [PATCH 003/199] ARM mach-at91: duplicated include
Message-ID: <1274645401-27734-1-git-send-email-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-at91/board-sam9m10g45ek.c: mach/hardware.h is included more than once

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-at91/board-sam9m10g45ek.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 98f9f4b..ee80059 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -25,7 +25,6 @@
 #include <linux/leds.h>
 #include <linux/clk.h>
 
-#include <mach/hardware.h>
 #include <video/atmel_lcdc.h>
 
 #include <asm/setup.h>
-- 
1.7.1.251.gf80a2
