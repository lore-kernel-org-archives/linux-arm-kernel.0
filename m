From: stigge@antcom.de (Roland Stigge)
Date: Sun, 24 Jun 2012 15:47:15 +0200
Subject: [PATCH 5/7] ARM: LPC32xx: Defconfig update
In-Reply-To: <1340545637-5449-1-git-send-email-stigge@antcom.de>
References: <1340545637-5449-1-git-send-email-stigge@antcom.de>
Message-ID: <1340545637-5449-6-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This defconfig update for LPC32xx adds interrupt and polled gpio keyboard
drivers.

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/arm/configs/lpc32xx_defconfig |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.orig/arch/arm/configs/lpc32xx_defconfig
+++ linux-2.6/arch/arm/configs/lpc32xx_defconfig
@@ -18,6 +18,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_LPC32XX=y
+CONFIG_KEYBOARD_GPIO_POLLED=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -89,6 +90,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_X=240
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=320
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_LPC32XX=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
