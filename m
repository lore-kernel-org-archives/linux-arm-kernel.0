From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 16:41:18 +0200
Subject: [PATCH v2 3/3] ARM: configs: add CONFIG_MMC_SDHCI_PXAV3 to the
 multi_v7_defconfig
In-Reply-To: <1397486478-16991-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397486478-16991-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397486478-16991-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 38x platform has a SDHCI interface managed by the
sdhci-pxav3 MMC host driver. It therefore makes sense to enable this
driver in multi_v7_defconfig, which supports the Armada 38x platform.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d4e8a47..d392f2d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -273,6 +273,7 @@ CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ESDHC_IMX=y
+CONFIG_MMC_SDHCI_PXAV3=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_SDHCI_DOVE=y
 CONFIG_MMC_SDHCI_SPEAR=y
-- 
1.8.3.2
