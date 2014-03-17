From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 17 Mar 2014 14:57:06 +0100
Subject: [PATCH v2 13/15] ARM: at91: remove atmel_tsadcc from sama5_defconfig
In-Reply-To: <1395064628-644-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395064628-644-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1395064628-644-14-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

atmel_tsadcc has been removed, stop selecting it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/configs/sama5_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index dc3881e07630..869fa18ebeb2 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -122,7 +122,6 @@ CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
-CONFIG_TOUCHSCREEN_ATMEL_TSADCC=y
 # CONFIG_SERIO is not set
 CONFIG_LEGACY_PTY_COUNT=4
 CONFIG_SERIAL_ATMEL=y
-- 
1.8.3.2
