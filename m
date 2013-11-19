From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Nov 2013 22:56:08 +0100
Subject: [PATCH] ARM: ux500: get rid of unused header
Message-ID: <1384898168-12809-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the unused inclusion of
<linux/platform_data/pinctrl-nomadik.h> which is
the last user in the entire kernel of this platform
data header.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-audio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500-audio.c b/arch/arm/mach-ux500/board-mop500-audio.c
index d52805979851..dc7f90157766 100644
--- a/arch/arm/mach-ux500/board-mop500-audio.c
+++ b/arch/arm/mach-ux500/board-mop500-audio.c
@@ -7,7 +7,6 @@
 #include <linux/platform_device.h>
 #include <linux/init.h>
 #include <linux/gpio.h>
-#include <linux/platform_data/pinctrl-nomadik.h>
 #include <linux/platform_data/dma-ste-dma40.h>
 
 #include "irqs.h"
-- 
1.8.3.1
