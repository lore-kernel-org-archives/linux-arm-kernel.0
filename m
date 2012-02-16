From: danny.kukawka@bisect.de (Danny Kukawka)
Date: Thu, 16 Feb 2012 15:45:42 +0100
Subject: [PATCH] arch/arm/mach-pxa/: included linux/gpio.h twice
Message-ID: <1329403542-32606-1-git-send-email-danny.kukawka@bisect.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-pxa/pxa25x.c and arch/arm/mach-pxa/saarb.c
included 'linux/gpio.h' twice, remove the duplicates.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/arm/mach-pxa/pxa25x.c |    1 -
 arch/arm/mach-pxa/saarb.c  |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 91e4f6c..00d6eac 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -25,7 +25,6 @@
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 
 #include <asm/mach/map.h>
 #include <asm/suspend.h>
diff --git a/arch/arm/mach-pxa/saarb.c b/arch/arm/mach-pxa/saarb.c
index febc809..5aded5e 100644
--- a/arch/arm/mach-pxa/saarb.c
+++ b/arch/arm/mach-pxa/saarb.c
@@ -15,7 +15,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
 #include <linux/mfd/88pm860x.h>
-#include <linux/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-- 
1.7.8.3
