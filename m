From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 13 Jul 2015 14:42:37 +0000
Subject: [PATCH 2/5] ARM: prima2_defconfig: enable build for SiRFSoC SDHC host
Message-ID: <1436798557-4245-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

this patch enables the MMC/SDHCI driver for SiRFSoC platforms.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/configs/prima2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
index ded0cad..cf3acc8 100644
--- a/arch/arm/configs/prima2_defconfig
+++ b/arch/arm/configs/prima2_defconfig
@@ -42,6 +42,7 @@ CONFIG_USB_MASS_STORAGE=m
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_SIRF=y
 CONFIG_DMADEVICES=y
 CONFIG_DMADEVICES_DEBUG=y
 CONFIG_DMADEVICES_VDEBUG=y
-- 
2.3.5
