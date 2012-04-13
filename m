From: thomas@tomweber.eu (Thomas Weber)
Date: Fri, 13 Apr 2012 19:33:04 +0200
Subject: [PATCH] ARM: MSM: Remove twice included header files
Message-ID: <1334338384-10728-1-git-send-email-thomas@tomweber.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove twice included gpio.h in board-msm7x30
and board-qsd8x50.

Signed-off-by: Thomas Weber <thomas@tomweber.eu>
---
 arch/arm/mach-msm/board-msm7x30.c |    1 -
 arch/arm/mach-msm/board-qsd8x50.c |    1 -
 2 files changed, 2 deletions(-)

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
1.7.10
