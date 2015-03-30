From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 30 Mar 2015 16:40:14 +0200
Subject: [PATCH 2/4] ARM: multi_v7_defconfig: Enable support for ELAN i2c
 trackpads
In-Reply-To: <1427726418-3806-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1427726418-3806-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1427726418-3806-2-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Needed in several Chromebook models such as the Tegra-based ones.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8e174ea..5b4d1c8 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -208,6 +208,7 @@ CONFIG_KEYBOARD_SPEAR=y
 CONFIG_KEYBOARD_ST_KEYSCAN=y
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_MOUSE_PS2_ELANTECH=y
+CONFIG_MOUSE_ELAN_I2C=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
 CONFIG_TOUCHSCREEN_ST1232=m
-- 
2.1.0
