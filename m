From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Nov 2013 13:58:54 +0100
Subject: [PATCH 1/2] ARM: lpc32xx: delete local <mach/gpio.h> header
Message-ID: <1385038734-9742-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This header is not used by anything, and since the arch does
not specify NEED_MACH_GPIO_H it is not included into
<linux/gpio.h> either. Delete it.

Cc: Roland Stigge <stigge@antcom.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Roland, can you please ACK this so I can take it through the
GPIO tree?
---
 arch/arm/mach-lpc32xx/include/mach/gpio.h | 6 ------
 1 file changed, 6 deletions(-)
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/gpio.h

diff --git a/arch/arm/mach-lpc32xx/include/mach/gpio.h b/arch/arm/mach-lpc32xx/include/mach/gpio.h
deleted file mode 100644
index 0052e7a76179..000000000000
--- a/arch/arm/mach-lpc32xx/include/mach/gpio.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __MACH_GPIO_H
-#define __MACH_GPIO_H
-
-#include "gpio-lpc32xx.h"
-
-#endif /* __MACH_GPIO_H */
-- 
1.8.3.1
