From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 27 Oct 2015 11:28:30 +0900
Subject: [PATCH 1/2] pinctrl: uniphier: enable UniPhier SoCs pinctrl drivers
 by default
Message-ID: <1445912911-1292-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "default y" to the Kconfig rather than adding entries into
arch/arm/configs/multi_v7_defconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/uniphier/Kconfig b/drivers/pinctrl/uniphier/Kconfig
index eab23ef..b1d2f941 100644
--- a/drivers/pinctrl/uniphier/Kconfig
+++ b/drivers/pinctrl/uniphier/Kconfig
@@ -7,26 +7,32 @@ config PINCTRL_UNIPHIER_CORE
 
 config PINCTRL_UNIPHIER_PH1_LD4
 	tristate "UniPhier PH1-LD4 SoC pinctrl driver"
+	default y
 	select PINCTRL_UNIPHIER_CORE
 
 config PINCTRL_UNIPHIER_PH1_PRO4
 	tristate "UniPhier PH1-Pro4 SoC pinctrl driver"
+	default y
 	select PINCTRL_UNIPHIER_CORE
 
 config PINCTRL_UNIPHIER_PH1_SLD8
 	tristate "UniPhier PH1-sLD8 SoC pinctrl driver"
+	default y
 	select PINCTRL_UNIPHIER_CORE
 
 config PINCTRL_UNIPHIER_PH1_PRO5
 	tristate "UniPhier PH1-Pro5 SoC pinctrl driver"
+	default y
 	select PINCTRL_UNIPHIER_CORE
 
 config PINCTRL_UNIPHIER_PROXSTREAM2
 	tristate "UniPhier ProXstream2 SoC pinctrl driver"
+	default y
 	select PINCTRL_UNIPHIER_CORE
 
 config PINCTRL_UNIPHIER_PH1_LD6B
 	tristate "UniPhier PH1-LD6b SoC pinctrl driver"
+	default y
 	select PINCTRL_UNIPHIER_CORE
 
 endif
-- 
1.9.1
