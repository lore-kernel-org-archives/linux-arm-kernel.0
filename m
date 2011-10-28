From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 28 Oct 2011 16:23:11 +0200
Subject: [PATCH] davinci: mark GPIO implementation complex
Message-ID: <1319811791-21302-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

When breaking apart the DaVinci GPIO files I accidentally
marked it non-complex while it is indeed complex.

Reported-by: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-davinci/include/mach/gpio.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/gpio.h b/arch/arm/mach-davinci/include/mach/gpio.h
index fbaae47..960e9de 100644
--- a/arch/arm/mach-davinci/include/mach/gpio.h
+++ b/arch/arm/mach-davinci/include/mach/gpio.h
@@ -15,6 +15,8 @@
 
 #include <asm-generic/gpio.h>
 
+#define __ARM_GPIOLIB_COMPLEX
+
 /* The inline versions use the static inlines in the driver header */
 #include "gpio-davinci.h"
 
-- 
1.7.3.2
