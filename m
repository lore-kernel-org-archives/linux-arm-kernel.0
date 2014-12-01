From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 1 Dec 2014 14:24:39 +0100
Subject: [PATCH 3/4] ARM: at91/defconfig: add QT1070 to at91_dt
In-Reply-To: <eb931e7c5534cd949ba61307f0380826e62ceb2c.1417440150.git.nicolas.ferre@atmel.com>
References: <eb931e7c5534cd949ba61307f0380826e62ceb2c.1417440150.git.nicolas.ferre@atmel.com>
Message-ID: <7b6024db44caadf536fd12fb18bf67181413ebe8.1417440150.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As this touch button driver is used on at91sam9x5ek, it's better to enable it.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index cb6ec18ce68b..6ccf937a60f2 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -113,6 +113,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=272
 CONFIG_INPUT_JOYDEV=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_QT1070=y
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
-- 
2.1.3
