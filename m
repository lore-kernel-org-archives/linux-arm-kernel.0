From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 09:34:02 +0900
Subject: [PATCH 1/2] ARM: shmobile: defconfig: enable HDMI output for RCar
In-Reply-To: <cover.1444869086.git.horms+renesas@verge.net.au>
References: <cover.1444869086.git.horms+renesas@verge.net.au>
Message-ID: <687dfe660a3eddbd40335694beb0896e26b5bbd9.1444869086.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Actviate HDMI output of the RCar DU (and LVDS while we are here).
Enable the HDMI encoder chip found on Lager/Koelsch boards.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 0bdeb4925be4..3aef019c0de7 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -140,7 +140,10 @@ CONFIG_VIDEO_RENESAS_VSP1=y
 CONFIG_VIDEO_ADV7180=y
 CONFIG_VIDEO_ML86V7667=y
 CONFIG_DRM=y
+CONFIG_DRM_I2C_ADV7511=y
 CONFIG_DRM_RCAR_DU=y
+CONFIG_DRM_RCAR_HDMI=y
+CONFIG_DRM_RCAR_LVDS=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FB_SH_MOBILE_MERAM=y
 # CONFIG_LCD_CLASS_DEVICE is not set
-- 
2.1.4
