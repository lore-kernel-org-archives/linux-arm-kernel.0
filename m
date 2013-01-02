From: anilkumar@ti.com (AnilKumar Ch)
Date: Wed, 2 Jan 2013 15:57:28 +0530
Subject: [PATCH v3 4/7] ARM: OMAP2+: omap2plus_defconfig: Add matrix-keypad
 support
In-Reply-To: <1357122451-7577-1-git-send-email-anilkumar@ti.com>
References: <1357122451-7577-1-git-send-email-anilkumar@ti.com>
Message-ID: <1357122451-7577-5-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM335X-EVM device have 3x2 matrix keypad, one has to manually enable
this support to use matrix keypad. So this patch enables matrix-keypad
driver as module in omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index cd1cd51..f3e0e8c 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -111,6 +111,7 @@ CONFIG_USB_KC2190=y
 CONFIG_INPUT_JOYDEV=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
+CONFIG_KEYBOARD_MATRIX=m
 CONFIG_KEYBOARD_TWL4030=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=y
-- 
1.7.9.5
