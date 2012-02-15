From: danny.kukawka@bisect.de (Danny Kukawka)
Date: Wed, 15 Feb 2012 20:19:38 +0100
Subject: [PATCH] arch/arm/mach-ux500/board-mop500-u8500uib.c: included
 linux/gpio.h twice
Message-ID: <1329333578-31773-1-git-send-email-danny.kukawka@bisect.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-ux500/board-mop500-u8500uib.c included 'linux/gpio.h'
remove the duplicate.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/arm/mach-ux500/board-mop500-u8500uib.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-u8500uib.c b/arch/arm/mach-ux500/board-mop500-u8500uib.c
index feb5744..ead91c9 100644
--- a/arch/arm/mach-ux500/board-mop500-u8500uib.c
+++ b/arch/arm/mach-ux500/board-mop500-u8500uib.c
@@ -8,7 +8,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/tc3589x.h>
 #include <linux/input/matrix_keypad.h>
-- 
1.7.8.3
