From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed,  3 Oct 2018 09:18:23 +0900
Subject: [PATCH 2/2] arm64: defconfig: enable CONFIG_MMC_UNIPHIER
In-Reply-To: <1538525903-22548-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538525903-22548-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1538525903-22548-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the UniPhier SD controller driver.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index db8d364..a15016e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -520,6 +520,7 @@ CONFIG_MMC_MESON_GX=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_SDHI=y
+CONFIG_MMC_UNIPHIER=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_HI3798CV200=y
-- 
2.7.4
