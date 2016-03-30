From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 16:19:37 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: add HLCDC drivers as modules
Message-ID: <1459347577-15450-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the HLCDC drivers to multi_v7_defconfig.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2823490..af1e0c9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -441,6 +441,7 @@ CONFIG_DIGICOLOR_WATCHDOG=y
 CONFIG_MFD_AS3711=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_ATMEL_FLEXCOM=y
+CONFIG_MFD_ATMEL_HLCDC=m
 CONFIG_MFD_BCM590XX=y
 CONFIG_MFD_AXP20X=y
 CONFIG_MFD_AXP20X_I2C=m
@@ -533,6 +534,7 @@ CONFIG_DRM_EXYNOS_FIMD=y
 CONFIG_DRM_EXYNOS_HDMI=y
 CONFIG_DRM_ROCKCHIP=m
 CONFIG_ROCKCHIP_DW_HDMI=m
+CONFIG_DRM_ATMEL_HLCDC=m
 CONFIG_DRM_RCAR_DU=m
 CONFIG_DRM_RCAR_HDMI=y
 CONFIG_DRM_RCAR_LVDS=y
@@ -775,6 +777,7 @@ CONFIG_AK8975=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_PWM=y
 CONFIG_PWM_ATMEL=m
+CONFIG_PWM_ATMEL_HLCDC_PWM=m
 CONFIG_PWM_ATMEL_TCB=m
 CONFIG_PWM_FSL_FTM=m
 CONFIG_PWM_RENESAS_TPU=y
-- 
2.5.0
