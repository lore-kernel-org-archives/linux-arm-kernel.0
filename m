From: jj@chaosbits.net (Jesper Juhl)
Date: Mon, 20 Jun 2011 10:40:32 +0200 (CEST)
Subject: [PATCH][Trivial] S3C2410 bluetooth: Remove duplicate linux/leds.h
	include
Message-ID: <alpine.LNX.2.00.1106201035590.18991@swampdragon.chaosbits.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the duplicate inclusion of linux/leds.h from 
arch/arm/mach-s3c2410/h1940-bluetooth.c that was added by commit 50e2d10d.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 h1940-bluetooth.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-s3c2410/h1940-bluetooth.c b/arch/arm/mach-s3c2410/h1940-bluetooth.c
index 2c126bb..a5eeb62 100644
--- a/arch/arm/mach-s3c2410/h1940-bluetooth.c
+++ b/arch/arm/mach-s3c2410/h1940-bluetooth.c
@@ -18,7 +18,6 @@
 #include <linux/leds.h>
 #include <linux/gpio.h>
 #include <linux/rfkill.h>
-#include <linux/leds.h>
 
 #include <mach/regs-gpio.h>
 #include <mach/hardware.h>

-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
