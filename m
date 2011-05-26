From: jj@chaosbits.net (Jesper Juhl)
Date: Thu, 26 May 2011 11:35:08 +0200 (CEST)
Subject: [PATCH][Trivial] ARM: remove duplicate include from
	arch/arm/mach-dove/common.c
Message-ID: <alpine.LNX.2.00.1105261130190.17400@swampdragon.chaosbits.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicate linux/serial_8250.h include from 
arch/arm/mach-dove/common.c that was introduced by commit 
5c60255149eece2a36ec9f5c99817b85f96fe8ec .

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 common.c |    1 -
 1 file changed, 1 deletion(-)

 note: untested patch since I have no way to really build arm stuff.
       patch is against Linus' tree.

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 5ed51b8..b6c3d6b 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -17,7 +17,6 @@
 #include <linux/clk.h>
 #include <linux/mbus.h>
 #include <linux/ata_platform.h>
-#include <linux/serial_8250.h>
 #include <linux/gpio.h>
 #include <asm/page.h>
 #include <asm/setup.h>


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
