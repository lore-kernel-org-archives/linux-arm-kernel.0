From: ezequiel.garcia@imgtec.com (Ezequiel Garcia)
Date: Wed, 25 Feb 2015 08:48:11 -0300
Subject: [PATCH 7/7] ARM: sunxi: Rename EFUSE_SUNXI option in defconfigs
Message-ID: <1424864891-3571-1-git-send-email-ezequiel.garcia@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the Sunxi eFuse driver move, the config is renamed.
Update the defconfigs.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 arch/arm/configs/sunxi_defconfig    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e8a4c95..caa84d2 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -145,7 +145,6 @@ CONFIG_ICS932S401=y
 CONFIG_APDS9802ALS=y
 CONFIG_ISL29003=y
 CONFIG_EEPROM_AT24=y
-CONFIG_EEPROM_SUNXI_SID=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_SCSI_MULTI_LUN=y
@@ -463,6 +462,7 @@ CONFIG_MSM_MMCC_8974=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_MEMORY=y
+CONFIG_EFUSE_SUNXI_SID=y
 CONFIG_TI_AEMIF=y
 CONFIG_IIO=y
 CONFIG_XILINX_XADC=y
diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 38840a8..484c06f 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -30,7 +30,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_EEPROM_SUNXI_SID=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_AHCI_SUNXI=y
@@ -105,6 +104,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_SUNXI=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EFUSE_SUNXI_SID=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
-- 
2.3.0
