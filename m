From: danny.kukawka@bisect.de (Danny Kukawka)
Date: Wed, 15 Feb 2012 20:19:09 +0100
Subject: [PATCH] arch/arm/mach-pxa/pxa27x.c: included linux/device.h twice
Message-ID: <1329333549-31663-1-git-send-email-danny.kukawka@bisect.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-lpc32xx/phy3250.c included 'linux/device.h' twice,
remove the duplicate.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/arm/mach-lpc32xx/phy3250.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index bfee5b4..8e312db 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -22,7 +22,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/dma-mapping.h>
-#include <linux/device.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
 #include <linux/leds.h>
-- 
1.7.8.3
