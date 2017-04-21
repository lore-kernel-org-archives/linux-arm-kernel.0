From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Fri, 21 Apr 2017 10:39:24 +0200
Subject: [PATCH v2 5/5] ARM: at91/defconfig: add PTC driver to sama5_defconfig
In-Reply-To: <20170421083924.15096-1-ludovic.desroches@microchip.com>
References: <20170421083924.15096-1-ludovic.desroches@microchip.com>
Message-ID: <20170421083924.15096-6-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Peripheral Touch Controller driver to sama5_defconfig.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 777c9e9..7480665 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -116,6 +116,8 @@ CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_ATMEL_PTC=m
 # CONFIG_SERIO is not set
 CONFIG_LEGACY_PTY_COUNT=4
 CONFIG_SERIAL_ATMEL=y
-- 
2.9.0
