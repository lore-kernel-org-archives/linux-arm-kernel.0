From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 31 Jan 2016 22:32:51 +0900
Subject: [PATCH] pinctrl: uniphier: add COMPILE_TEST option
Message-ID: <1454247171-25028-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add COMPILE_TEST for the compilation test coverage.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/uniphier/Kconfig b/drivers/pinctrl/uniphier/Kconfig
index 7abd614..43f689f 100644
--- a/drivers/pinctrl/uniphier/Kconfig
+++ b/drivers/pinctrl/uniphier/Kconfig
@@ -1,6 +1,6 @@
 menuconfig PINCTRL_UNIPHIER
 	bool "UniPhier SoC pinctrl drivers"
-	depends on ARCH_UNIPHIER
+	depends on ARCH_UNIPHIER || COMPILE_TEST
 	depends on OF && MFD_SYSCON
 	default y
 	select PINMUX
-- 
1.9.1
