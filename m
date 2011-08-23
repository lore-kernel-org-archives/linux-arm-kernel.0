From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 23 Aug 2011 09:26:21 +0200
Subject: [PATCH] plat-nomadik: kill off <plat/gpio.h>
Message-ID: <1314084381-5034-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

After recent consolidations the Nomadik <plat/gpio.h> is entirely
superfluous, so get rid of it.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/include/mach/gpio.h |    2 --
 arch/arm/mach-ux500/include/mach/gpio.h   |    2 --
 arch/arm/plat-nomadik/include/plat/gpio.h |   17 -----------------
 3 files changed, 0 insertions(+), 21 deletions(-)
 delete mode 100644 arch/arm/plat-nomadik/include/plat/gpio.h

diff --git a/arch/arm/mach-nomadik/include/mach/gpio.h b/arch/arm/mach-nomadik/include/mach/gpio.h
index 7a81a04..efdde0a 100644
--- a/arch/arm/mach-nomadik/include/mach/gpio.h
+++ b/arch/arm/mach-nomadik/include/mach/gpio.h
@@ -1,6 +1,4 @@
 #ifndef __ASM_ARCH_GPIO_H
 #define __ASM_ARCH_GPIO_H
 
-#include <plat/gpio.h>
-
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-ux500/include/mach/gpio.h b/arch/arm/mach-ux500/include/mach/gpio.h
index 3c4cd31..7389df9 100644
--- a/arch/arm/mach-ux500/include/mach/gpio.h
+++ b/arch/arm/mach-ux500/include/mach/gpio.h
@@ -7,6 +7,4 @@
  */
 #define ARCH_NR_GPIOS	350
 
-#include <plat/gpio.h>
-
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/plat-nomadik/include/plat/gpio.h b/arch/arm/plat-nomadik/include/plat/gpio.h
deleted file mode 100644
index 78c0c0f..0000000
--- a/arch/arm/plat-nomadik/include/plat/gpio.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Structures and registers for GPIO access in the Nomadik SoC
- *
- * Copyright (C) 2008 STMicroelectronics
- *     Author: Prafulla WADASKAR <prafulla.wadaskar@st.com>
- * Copyright (C) 2009 Alessandro Rubini <rubini@unipv.it>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __ASM_PLAT_GPIO_H
-#define __ASM_PLAT_GPIO_H
-
-#include <linux/kernel.h>
-
-#endif /* __ASM_PLAT_GPIO_H */
-- 
1.7.3.2
