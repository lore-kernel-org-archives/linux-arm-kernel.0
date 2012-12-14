From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 14 Dec 2012 11:03:01 +0530
Subject: [PATCH v2 5/8] ARM: OMAP2+: omap2plus_defconfig: Enable matrix keypad
 driver
In-Reply-To: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
References: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
Message-ID: <1355463184-16283-6-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM335X-EVM device have 3x2 matrix keypad, one has to manually enable
this support to use matrix keypad. So this patch enables matrix keypad
driver in omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index f0d6afb..c004d9b 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -109,6 +109,7 @@ CONFIG_USB_KC2190=y
 CONFIG_INPUT_JOYDEV=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
+CONFIG_KEYBOARD_MATRIX=y
 CONFIG_KEYBOARD_TWL4030=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=y
-- 
1.7.9.5
