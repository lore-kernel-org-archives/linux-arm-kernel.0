From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 26 Sep 2014 14:14:57 +0800
Subject: [PATCH] ARM: berlin: sort Kconfig options
Message-ID: <1411712097-700-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keep options alphabetically sorted.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/mach-berlin/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
index 5803f77..84d34e0 100644
--- a/arch/arm/mach-berlin/Kconfig
+++ b/arch/arm/mach-berlin/Kconfig
@@ -3,9 +3,9 @@ menuconfig ARCH_BERLIN
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
-	select GENERIC_IRQ_CHIP
 	select DW_APB_ICTL
 	select DW_APB_TIMER_OF
+	select GENERIC_IRQ_CHIP
 	select PINCTRL
 	select RESET_CONTROLLER
 
-- 
2.1.1
