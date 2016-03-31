From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 31 Mar 2016 09:45:24 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Remove unused Kconfig option
 MACH_UX500_DT
Message-ID: <1459413924-19351-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2823490..c9c5ac0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -105,7 +105,6 @@ CONFIG_ARCH_UNIPHIER=y
 CONFIG_ARCH_U8500=y
 CONFIG_MACH_HREFV60=y
 CONFIG_MACH_SNOWBALL=y
-CONFIG_MACH_UX500_DT=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_VEXPRESS_CA9X4=y
 CONFIG_ARCH_VEXPRESS_TC2_PM=y
-- 
1.9.1
