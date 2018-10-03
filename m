From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed,  3 Oct 2018 09:18:22 +0900
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: enable CONFIG_MMC_UNIPHIER
Message-ID: <1538525903-22548-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the UniPhier SD controller driver.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fc33444..0d56568 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -771,6 +771,7 @@ CONFIG_MMC_ATMELMCI=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_MMC_SDHI=y
+CONFIG_MMC_UNIPHIER=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_ROCKCHIP=y
-- 
2.7.4
