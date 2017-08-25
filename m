From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Fri, 25 Aug 2017 11:19:19 +0800
Subject: [v2] ARM: multi_v7_defconfig: make eSDHC driver built-in
Message-ID: <20170825031919.22492-1-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes root file system is deployed on SD card. It's
proper to build eSDHC driver into kernel.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Added more reviewers (by get_maintainer.pl).
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index cb1830bb7ce5..8071d483859c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -712,7 +712,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_ARASAN=y
 CONFIG_MMC_SDHCI_OF_AT91=y
-CONFIG_MMC_SDHCI_OF_ESDHC=m
+CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_MMC_SDHCI_ESDHC_IMX=y
 CONFIG_MMC_SDHCI_DOVE=y
 CONFIG_MMC_SDHCI_TEGRA=y
-- 
2.14.1
