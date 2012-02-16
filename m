From: danny.kukawka@bisect.de (Danny Kukawka)
Date: Thu, 16 Feb 2012 15:46:14 +0100
Subject: [PATCH] arch/arm/mach-ks8695/leds.c: included linux/gpio.h twice
Message-ID: <1329403574-32717-1-git-send-email-danny.kukawka@bisect.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-ks8695/leds.c: included 'linux/gpio.h' twice,
remove the duplicate.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/arm/mach-ks8695/leds.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ks8695/leds.c b/arch/arm/mach-ks8695/leds.c
index d6f6502..4bd7075 100644
--- a/arch/arm/mach-ks8695/leds.c
+++ b/arch/arm/mach-ks8695/leds.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
 
 #include <asm/leds.h>
 #include <mach/devices.h>
-- 
1.7.8.3
