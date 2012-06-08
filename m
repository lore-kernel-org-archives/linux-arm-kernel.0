From: andrew@lunn.ch (Andrew Lunn)
Date: Fri,  8 Jun 2012 10:58:57 +0200
Subject: [PATCH] ARM: iconnect: Remove include of removed linux/spi/orion_spi.h
Message-ID: <1339145937-24890-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3.5-rc1 fails to build when DT and iconnect is enabled because of
this now none existant include file.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-kirkwood/board-iconnect.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-kirkwood/board-iconnect.c b/arch/arm/mach-kirkwood/board-iconnect.c
index 2222c57..fa1cbdb 100644
--- a/arch/arm/mach-kirkwood/board-iconnect.c
+++ b/arch/arm/mach-kirkwood/board-iconnect.c
@@ -22,7 +22,6 @@
 #include <linux/leds.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/orion_spi.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
-- 
1.7.10
