From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 8 Jul 2015 20:57:35 +0530
Subject: [PATCH 2/4] ARM: omap2plus_defconfig: enable support for TI
 touchscreen
In-Reply-To: <cover.1436368740.git.nsekhar@ti.com>
References: <cover.1436368740.git.nsekhar@ti.com>
Message-ID: <705c659741e8ec9114cd9d555b1a73a7ca90015d.1436368740.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for on-chip resistive touchscreen m found on AM335x and
AM437x devices.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a8eb36454b14..294059d5ef80 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -208,6 +208,7 @@ CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_TOUCHSCREEN_PIXCIR=m
 CONFIG_TOUCHSCREEN_TSC2005=m
 CONFIG_TOUCHSCREEN_TSC2007=m
+CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_TPS65218_PWRBUTTON=m
 CONFIG_INPUT_TWL4030_PWRBUTTON=m
-- 
2.4.4.408.g16da57c
