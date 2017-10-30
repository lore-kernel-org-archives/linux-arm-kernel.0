From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 30 Oct 2017 19:00:52 +0900
Subject: [PATCH] arm64: defconfig: enable CONFIG_GPIO_UNIPHIER
Message-ID: <1509357652-24914-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the GPIO controller driver used for UniPhier SoC family.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ceb9ca2..6b4df78 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -297,6 +297,7 @@ CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_RCAR=y
+CONFIG_GPIO_UNIPHIER=y
 CONFIG_GPIO_XGENE=y
 CONFIG_GPIO_XGENE_SB=y
 CONFIG_GPIO_PCA953X=y
-- 
2.7.4
