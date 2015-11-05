From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  5 Nov 2015 15:47:55 +0900
Subject: [PATCH] ARM: uniphier: select PINCTRL
Message-ID: <1446706075-7348-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UniPhier SoCs support pinctrl drivers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-uniphier/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-uniphier/Kconfig b/arch/arm/mach-uniphier/Kconfig
index b640458..82dddee 100644
--- a/arch/arm/mach-uniphier/Kconfig
+++ b/arch/arm/mach-uniphier/Kconfig
@@ -6,6 +6,7 @@ config ARCH_UNIPHIER
 	select ARM_GIC
 	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
+	select PINCTRL
 	help
 	  Support for UniPhier SoC family developed by Socionext Inc.
 	  (formerly, System LSI Business Division of Panasonic Corporation)
-- 
1.9.1
