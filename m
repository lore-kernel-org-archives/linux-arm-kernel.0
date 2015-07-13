From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 13 Jul 2015 14:43:20 +0000
Subject: [PATCH 4/5] ARM: prima2_defconfig: enable build for RTC
Message-ID: <1436798600-4319-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

This patch enables RTC_CLASS and RTC driver for SiRFSoC platforms.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/configs/prima2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
index 88d416f..a9c1c33 100644
--- a/arch/arm/configs/prima2_defconfig
+++ b/arch/arm/configs/prima2_defconfig
@@ -44,6 +44,8 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_SIRF=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_SIRFSOC=y
 CONFIG_DMADEVICES=y
 CONFIG_DMADEVICES_DEBUG=y
 CONFIG_DMADEVICES_VDEBUG=y
-- 
2.3.5
