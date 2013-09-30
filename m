From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Sep 2013 17:39:27 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: add SDHCI for i.MX
Message-ID: <1380501567-6175-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Turn on SDHCI for i.MX support so machines can boot with local rootfs
on SD. Tested on a Wandboard Quad.

Signed-off-by: Olof Johansson <olof@lixom.net>
---

I'll apply this in the fixes branch for 3.12 since it increases test
coverage in my setup here.

 arch/arm/configs/multi_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f3935b4..119fc37 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -135,6 +135,7 @@ CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_ESDHC_IMX=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_SDHCI_SPEAR=y
 CONFIG_MMC_OMAP=y
-- 
1.7.10.4
