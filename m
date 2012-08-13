From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 13 Aug 2012 13:58:07 +0200
Subject: [PATCH 5/7] ARM: u300: delete remnant clkdev.h file
Message-ID: <1344859087-29444-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The U300 now uses common clk, delete this leftover.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/include/mach/clkdev.h | 7 -------
 1 file changed, 7 deletions(-)
 delete mode 100644 arch/arm/mach-u300/include/mach/clkdev.h

diff --git a/arch/arm/mach-u300/include/mach/clkdev.h b/arch/arm/mach-u300/include/mach/clkdev.h
deleted file mode 100644
index 92e3cc8..0000000
--- a/arch/arm/mach-u300/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __MACH_CLKDEV_H
-#define __MACH_CLKDEV_H
-
-int __clk_get(struct clk *clk);
-void __clk_put(struct clk *clk);
-
-#endif
-- 
1.7.11.3
