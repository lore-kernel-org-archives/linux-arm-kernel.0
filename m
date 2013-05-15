From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 16 May 2013 01:59:54 +0400
Subject: [PATCH v4 3/3] ARM: shmobile: Marzen: enable VIN and ADV7180 in
 defconfig
In-Reply-To: <201305160153.29827.sergei.shtylyov@cogentembedded.com>
References: <201305160153.29827.sergei.shtylyov@cogentembedded.com>
Message-ID: <201305160159.55056.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Add the VIN and ADV7180 drivers to 'marzen_defconfig'.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/configs/marzen_defconfig |    7 +++++++
 1 file changed, 7 insertions(+)

Index: renesas/arch/arm/configs/marzen_defconfig
===================================================================
--- renesas.orig/arch/arm/configs/marzen_defconfig
+++ renesas/arch/arm/configs/marzen_defconfig
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
