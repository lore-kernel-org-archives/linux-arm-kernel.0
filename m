From: jsarha@ti.com (Jyri Sarha)
Date: Mon, 27 Jan 2014 17:37:56 +0200
Subject: [PATCH RFC v3 7/8] ARM: OMAP2+: omap2plus_defconfig: Enable tilcdc
 and TDA998X HDMI support
In-Reply-To: <cover.1390836773.git.jsarha@ti.com>
References: <cover.1390836773.git.jsarha@ti.com>
Message-ID: <6bc6cf572b55bcc572d14c39a8dd3b85380f7d59.1390836773.git.jsarha@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables HDMI video support on Beaglebone-Black.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
cc: tony at atomide.com
---
 arch/arm/configs/omap2plus_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index bfa80a1..9288172 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -180,6 +180,9 @@ CONFIG_REGULATOR_TPS6507X=y
 CONFIG_REGULATOR_TPS65217=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
+CONFIG_DRM=m
+CONFIG_DRM_I2C_NXP_TDA998X=m
+CONFIG_DRM_TILCDC=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
-- 
1.7.9.5
