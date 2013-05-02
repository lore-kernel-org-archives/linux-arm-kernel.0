From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 2 May 2013 18:16:51 +0200
Subject: [PATCH 3/7] ARM: u300: delete <mach/hardware.h>
In-Reply-To: <1367511416-4312-1-git-send-email-linus.walleij@stericsson.com>
References: <1367511416-4312-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1367511416-4312-4-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This file is now unused and can be deleted.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/include/mach/hardware.h | 5 -----
 arch/arm/mach-u300/timer.c                 | 1 -
 2 files changed, 6 deletions(-)
 delete mode 100644 arch/arm/mach-u300/include/mach/hardware.h

diff --git a/arch/arm/mach-u300/include/mach/hardware.h b/arch/arm/mach-u300/include/mach/hardware.h
deleted file mode 100644
index b99d4ce..0000000
--- a/arch/arm/mach-u300/include/mach/hardware.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-u300/include/mach/hardware.h
- */
-#include <asm/sizes.h>
-#include <mach/u300-regs.h>
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 564e32d..2e622f9 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -22,7 +22,6 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 
 /* Generic stuff */
-- 
1.7.11.3
