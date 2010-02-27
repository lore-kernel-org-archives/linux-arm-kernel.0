From: jaswinder@kernel.org (Jaswinder Singh Rajput)
Date: Sat, 27 Feb 2010 14:17:30 +0530
Subject: [PATCH] ARM: includecheck fix for mach-at91/board-sam9m10g45ek.c
Message-ID: <1267260450.26906.9.camel@i7.satnam>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fix the following 'make includecheck' warning:
  arch/arm/mach-at91/board-sam9m10g45ek.c: mach/hardware.h is included more than once.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-at91/board-sam9m10g45ek.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 98f9f4b..f2ba9e2 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -36,7 +36,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/hardware.h>
 #include <mach/board.h>
 #include <mach/gpio.h>
 #include <mach/at91sam9_smc.h>
-- 
1.6.6
