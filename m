From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:18:09 +0100
Subject: [PATCH 1/4] ARM: shmobile: defconfig: Enable CONFIG_VIDEO_ADV7604
In-Reply-To: <cover.1483701293.git.horms+renesas@verge.net.au>
References: <cover.1483701293.git.horms+renesas@verge.net.au>
Message-ID: <1682a9c5694d228041dc7ff59f49427c83920675.1483701293.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

The adv7612 is used on Gen2 boards (Lager, Koelsch and Gose) for HDMI
input. Enable support for this chip in shmobile_defconfig.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 1b0f8ae36fb3..98e9ce66740d 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -145,6 +145,7 @@ CONFIG_VIDEO_RENESAS_JPU=y
 CONFIG_VIDEO_RENESAS_VSP1=y
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_VIDEO_ADV7180=y
+CONFIG_VIDEO_ADV7604=y
 CONFIG_VIDEO_ML86V7667=y
 CONFIG_DRM=y
 CONFIG_DRM_I2C_ADV7511=y
-- 
2.7.0.rc3.207.g0ac5344
