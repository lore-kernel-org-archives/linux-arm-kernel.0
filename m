From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Apr 2012 11:50:35 -0600
Subject: [PATCH 2/2] ARM: add EM3027 RTC to tegra_defconfig
In-Reply-To: <1335549035-22286-1-git-send-email-swarren@wwwdotorg.org>
References: <1335549035-22286-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1335549035-22286-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The IIO option seems to have been moved recently too.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This will be squashed into the existing defconfig commit
---
 arch/arm/configs/tegra_defconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 310fe81..7a90abb 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -138,9 +138,9 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_EM3027=y
 CONFIG_RTC_DRV_TEGRA=y
 CONFIG_STAGING=y
-CONFIG_IIO=y
 CONFIG_SENSORS_ISL29018=y
 CONFIG_SENSORS_ISL29028=y
 CONFIG_SENSORS_AK8975=y
@@ -149,6 +149,7 @@ CONFIG_KEYBOARD_NVEC=y
 CONFIG_SERIO_NVEC_PS2=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
+CONFIG_IIO=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
1.7.0.4
