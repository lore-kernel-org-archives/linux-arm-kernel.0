From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 23 Aug 2013 01:27:08 +0400
Subject: [PATCH v5 3/3] ARM: shmobile: Marzen: enable VIN and ADV7180 in
 defconfig
In-Reply-To: <201308230119.13783.sergei.shtylyov@cogentembedded.com>
References: <201308230119.13783.sergei.shtylyov@cogentembedded.com>
Message-ID: <201308230127.09051.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Add the VIN and ADV7180 drivers to 'marzen_defconfig'.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/configs/marzen_defconfig |    7 +++++++
 1 file changed, 7 insertions(+)

Index: media_tree/arch/arm/configs/marzen_defconfig
===================================================================
--- media_tree.orig/arch/arm/configs/marzen_defconfig
+++ media_tree/arch/arm/configs/marzen_defconfig
@@ -84,6 +84,13 @@ CONFIG_GPIO_RCAR=y
 CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_SSB=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_SOC_CAMERA=y
+CONFIG_VIDEO_RCAR_VIN=y
+# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
+CONFIG_VIDEO_ADV7180=y
 CONFIG_USB=y
 CONFIG_USB_RCAR_PHY=y
 CONFIG_MMC=y
