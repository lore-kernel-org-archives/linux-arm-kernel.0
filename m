From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Dec 2015 14:24:53 +0900
Subject: [PATCH 3/7] ARM: shmobile: defconfig: Enable missing support based on
 DTSes
In-Reply-To: <cover.1450315426.git.horms+renesas@verge.net.au>
References: <cover.1450315426.git.horms+renesas@verge.net.au>
Message-ID: <6161cc147277e7537d73a45d732a7112997c20f6.1450315426.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Enable all missing support, extracted from the various Renesas ARM DTSes
using linux-config-from-dt.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 91233ed27578..d2259952879d 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -52,6 +52,8 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
+CONFIG_CAN=y
+CONFIG_CAN_RCAR=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
@@ -98,6 +100,7 @@ CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=20
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_EMEV2=y
 CONFIG_I2C_GPIO=y
 CONFIG_I2C_RIIC=y
 CONFIG_I2C_SH_MOBILE=y
@@ -134,6 +137,7 @@ CONFIG_SOC_CAMERA=y
 CONFIG_SOC_CAMERA_PLATFORM=y
 CONFIG_VIDEO_RCAR_VIN=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_RENESAS_JPU=y
 CONFIG_VIDEO_RENESAS_VSP1=y
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_VIDEO_ADV7180=y
@@ -175,9 +179,11 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
 CONFIG_RTC_DRV_S35390A=y
 CONFIG_RTC_DRV_RX8581=y
+CONFIG_RTC_DRV_DA9063=y
 CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
 CONFIG_RCAR_DMAC=y
+CONFIG_RENESAS_USB_DMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_AK8975=y
-- 
2.1.4
