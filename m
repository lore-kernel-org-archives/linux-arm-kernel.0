From: jj@chaosbits.net (Jesper Juhl)
Date: Sun, 5 Feb 2012 01:20:35 +0100 (CET)
Subject: [PATCH] ARM, KS8695: Only include linux/gpio.h once in
 arch/arm/mach-ks8695/leds.c
Message-ID: <alpine.LNX.2.00.1202050119020.30244@swampdragon.chaosbits.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the unneeded duplicate include.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 arch/arm/mach-ks8695/leds.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ks8695/leds.c b/arch/arm/mach-ks8695/leds.c
index d6f6502..4bd7075 100644
--- a/arch/arm/mach-ks8695/leds.c
+++ b/arch/arm/mach-ks8695/leds.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
 
 #include <asm/leds.h>
 #include <mach/devices.h>
-- 
1.7.9


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
