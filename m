From: balbi@ti.com (Felipe Balbi)
Date: Fri, 26 Dec 2014 13:28:24 -0600
Subject: [PATCH 5/5] arm: omap2plus_defconfig: enable TPS65218 power button
In-Reply-To: <1419622104-25812-1-git-send-email-balbi@ti.com>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
Message-ID: <1419622104-25812-6-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable tps65218 power button driver by default as
a dynamically linked module so AM437x SK can report
power button presses.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index c2c3a85..f4a4b2f 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -183,6 +183,7 @@ CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_TOUCHSCREEN_TSC2005=m
 CONFIG_TOUCHSCREEN_TSC2007=m
 CONFIG_INPUT_MISC=y
+CONFIG_INPUT_TPS65218_PWRBUTTON=m
 CONFIG_INPUT_TWL4030_PWRBUTTON=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
-- 
2.2.0
