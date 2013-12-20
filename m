From: jsarha@ti.com (Jyri Sarha)
Date: Fri, 20 Dec 2013 12:42:35 +0200
Subject: [PATCH RFC v2 REPOST 7/8] ARM: OMAP2+: omap2plus_defconfig: Enable
 tilcdc and TDA998X HDMI support
In-Reply-To: <cover.1387535299.git.jsarha@ti.com>
References: <cover.1387535299.git.jsarha@ti.com>
Message-ID: <356519246c8bea1ef776924810b824255f166bae.1387535303.git.jsarha@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables HDMI video support on Beaglebone-Black.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
cc: tony at atomide.com
---
 arch/arm/configs/omap2plus_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 254cf05..52b0d92 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -176,6 +176,9 @@ CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
 CONFIG_REGULATOR_TPS65217=y
 CONFIG_REGULATOR_TPS65910=y
+CONFIG_DRM=m
+CONFIG_DRM_I2C_NXP_TDA998X=m
+CONFIG_DRM_TILCDC=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
-- 
1.7.9.5
