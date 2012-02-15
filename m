From: danny.kukawka@bisect.de (Danny Kukawka)
Date: Wed, 15 Feb 2012 20:18:48 +0100
Subject: [PATCH] arch/arm/mach-msm: linux/gpio.h included twice
Message-ID: <1329333528-31605-1-git-send-email-danny.kukawka@bisect.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-msm/board-msm7x30.c and arch/arm/mach-msm/board-qsd8x50.c
included 'linux/gpio.h' twice, remove the duplicates.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/arm/mach-msm/board-msm7x30.c |    1 -
 arch/arm/mach-msm/board-qsd8x50.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index db81ed5..75b3cfc 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -17,7 +17,6 @@
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/io.h>
diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 7e8909c..fbaa4ed 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -17,7 +17,6 @@
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/usb/msm_hsusb.h>
-- 
1.7.8.3
