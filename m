From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Nov 2014 12:07:00 -0600
Subject: [PATCH 02/10] arm: omap: omap2plus_defconfig: enable EDT FT5X06
 touchscreen
In-Reply-To: <1416334028-7766-1-git-send-email-balbi@ti.com>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
Message-ID: <1416334028-7766-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM437x Starter Kit ships with EDT FT5306 touchscreen
device. By enabling the driver we make sure touchscreen
will work out of the box.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 24d6fe2..c893487 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -177,6 +177,7 @@ CONFIG_KEYBOARD_MATRIX=m
 CONFIG_KEYBOARD_TWL4030=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=m
+CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_TOUCHSCREEN_TSC2005=m
 CONFIG_TOUCHSCREEN_TSC2007=m
 CONFIG_INPUT_MISC=y
-- 
2.1.0.GIT
