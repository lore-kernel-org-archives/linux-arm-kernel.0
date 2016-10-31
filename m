From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 31 Oct 2016 12:09:59 +0100
Subject: [PATCH 10/10] arm64: configs: enable SDHCI driver for Xenon
In-Reply-To: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
Message-ID: <0b7d2e802794d18ed16ab0983f5ba1f02d035be5.1477911954.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the driver for the SDHCI controller found on the
Marvell Armada 3700 and 7K/8K ARM64 SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+), 0 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dab2cb0c1f1c..2d1f5ee62b18 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -353,6 +353,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_K3=y
 CONFIG_MMC_SUNXI=y
+CONFIG_MMC_SDHCI_XENON=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
git-series 0.8.10
