From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 23 Apr 2014 20:00:51 +0530
Subject: [PATCH v5 9/9] ARM: exynos_defconfig: Remove SAMSUNG_USB3PHY config
In-Reply-To: <1398263451-18023-1-git-send-email-gautam.vivek@samsung.com>
References: <1398263451-18023-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1398263451-18023-10-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After removing the phy-samsung-usb3 driver, this config
should be removed.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 arch/arm/configs/exynos_defconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 4ce7b70..22cfc75 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -99,7 +99,6 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_PHY=y
 CONFIG_SAMSUNG_USB2PHY=y
-CONFIG_SAMSUNG_USB3PHY=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_S3C=y
-- 
1.7.10.4
