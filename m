From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  2 Jan 2013 22:41:11 +0100
Subject: [PATCH 1/2] ARM: nomadik: delete dangling include
Message-ID: <1357162871-6915-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reference to the old include header for the FSMC NAND
MTD driver was somehow left in place, get rid of it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/board-nhk8815.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 98167a4..9f19069 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -27,7 +27,6 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/pinctrl-nomadik.h>
 #include <linux/platform_data/clocksource-nomadik-mtu.h>
-#include <linux/platform_data/mtd-nomadik-nand.h>
 #include <asm/hardware/vic.h>
 #include <asm/sizes.h>
 #include <asm/mach-types.h>
-- 
1.7.11.7
