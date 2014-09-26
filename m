From: pramod.gurav@smartplayin.com (Pramod Gurav)
Date: Fri, 26 Sep 2014 17:29:52 +0530
Subject: [PATCH] ARM: multi_v7_defconfig: Add Support for QCOM SDHCI Controller
Message-ID: <1411732792-12687-1-git-send-email-pramod.gurav@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change adds support for Qualcomm SDHCI Controller found in
SOCs such as apq8074. This helps to get Dragonboard 8074 booted
with File system from emmc.

Tested on Intrynsic Dragonboard APQ8074.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-arm-msm at vger.kernel.org
Cc: Georgi Djakov <gdjakov@mm-sol.com>
Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---
 arch/arm/configs/multi_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index bad9d92..cc55117 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -328,6 +328,7 @@ CONFIG_MMC_SDHCI_BCM_KONA=y
 CONFIG_MMC_SDHCI_ST=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
+CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_MMC_SUNXI=y
 CONFIG_MMC_DW=y
-- 
1.7.9.5
