From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 23 Aug 2013 01:40:36 +0400
Subject: [PATCH v6 3/3] ARM: shmobile: BOCK-W: enable VIN and ML86V7667 in
 defconfig
In-Reply-To: <201308230134.26092.sergei.shtylyov@cogentembedded.com>
References: <201308230134.26092.sergei.shtylyov@cogentembedded.com>
Message-ID: <201308230140.37614.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Add the VIN and ML86V7667 drivers to 'bockw_defconfig'.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes since version 4:
- resolved reject.

 arch/arm/configs/bockw_defconfig |    7 +++++++
 1 file changed, 7 insertions(+)

Index: media_tree/arch/arm/configs/bockw_defconfig
===================================================================
--- media_tree.orig/arch/arm/configs/bockw_defconfig
+++ media_tree/arch/arm/configs/bockw_defconfig
@@ -82,6 +82,13 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HWMON is not set
 CONFIG_I2C=y
 CONFIG_I2C_RCAR=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_SOC_CAMERA=y
+CONFIG_VIDEO_RCAR_VIN=y
+# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
+CONFIG_VIDEO_ML86V7667=y
 CONFIG_SPI=y
 CONFIG_SPI_SH_HSPI=y
 CONFIG_USB=y
