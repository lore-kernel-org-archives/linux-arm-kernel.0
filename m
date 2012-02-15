From: danny.kukawka@bisect.de (Danny Kukawka)
Date: Wed, 15 Feb 2012 20:19:25 +0100
Subject: [PATCH] arch/arm/mach-pxa/pxa27x.c: included linux/gpio.h twice
Message-ID: <1329333565-31718-1-git-send-email-danny.kukawka@bisect.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-pxa/pxa27x.c included 'linux/gpio.h' twice, remove
the duplicate.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/arm/mach-pxa/pxa27x.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index aed6cbc..c1673b3 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -22,7 +22,6 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/i2c/pxa-i2c.h>
-#include <linux/gpio.h>
 
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
-- 
1.7.8.3
