From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 26 Dec 2016 11:14:53 +0900
Subject: [PATCH] arm64: defconfig: enable CONFIG_MMC_SDHCI_CADENCE
Message-ID: <1482718493-6792-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Cadence SD/SDIO/eMMC controller.  This is used on
Socionext UniPhier SoC family.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0888cab..23045b4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -384,6 +384,7 @@ CONFIG_MMC_SDHCI_ACPI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_ARASAN=y
 CONFIG_MMC_SDHCI_OF_ESDHC=y
+CONFIG_MMC_SDHCI_CADENCE=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_SPI=y
-- 
2.7.4
