From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 30 Oct 2017 19:00:37 +0900
Subject: [PATCH] ARM: multi_v7_defconfig: enable CONFIG_GPIO_UNIPHIER
Message-ID: <1509357637-24833-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the GPIO controller driver used for UniPhier SoC family.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f857d3f..28668e4 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -423,6 +423,7 @@ CONFIG_GPIO_DAVINCI=y
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_EM=y
 CONFIG_GPIO_RCAR=y
+CONFIG_GPIO_UNIPHIER=y
 CONFIG_GPIO_XILINX=y
 CONFIG_GPIO_ZYNQ=y
 CONFIG_GPIO_PCA953X=y
-- 
2.7.4
