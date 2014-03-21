From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Mar 2014 14:56:58 -0600
Subject: [PATCH] ARM: update multi_v7_defconfig for Tegra
Message-ID: <1395435418-1376-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This patch adds the same options to multi_v7_defconfig as were added to
tegra_defconfig in commit d1c912c1001f "ARM: tegra: defconfig updates".
(CONFIG_POWER_RESET_AS3722 is already enabled here.)

Suggested-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/configs/multi_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 9ee12b54ca7d..0585215bc2ee 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -102,6 +102,7 @@ CONFIG_RFKILL_GPIO=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_OMAP_OCP2SCP=y
 CONFIG_MTD=y
 CONFIG_MTD_M25P80=y
@@ -170,6 +171,7 @@ CONFIG_SERIAL_ST_ASC=y
 CONFIG_SERIAL_ST_ASC_CONSOLE=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_MUX_PINCTRL=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_I2C_MV64XXX=y
@@ -226,6 +228,8 @@ CONFIG_REGULATOR_VEXPRESS=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_USB_SUPPORT=y
+CONFIG_USB_VIDEO_CLASS=y
+CONFIG_USB_GSPCA=y
 CONFIG_DRM=y
 CONFIG_DRM_TEGRA=y
 CONFIG_DRM_PANEL_SIMPLE=y
-- 
1.8.1.5
