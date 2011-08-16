From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 16 Aug 2011 14:27:54 -0300
Subject: [PATCH] ARM: mxs: Remove unused header file
Message-ID: <1313515674-29048-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mxs/mach-mx23evk.c       |    1 -
 arch/arm/mach-mxs/mach-mx28evk.c       |    1 -
 arch/arm/mach-mxs/mach-stmp378x_devb.c |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
index 3c2de33..99b01e9 100644
--- a/arch/arm/mach-mxs/mach-mx23evk.c
+++ b/arch/arm/mach-mxs/mach-mx23evk.c
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-#include <linux/irq.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index eaaf6ff..3f86e7a 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -16,7 +16,6 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
-#include <linux/irq.h>
 #include <linux/clk.h>
 
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-mxs/mach-stmp378x_devb.c b/arch/arm/mach-mxs/mach-stmp378x_devb.c
index 7f38d82..3fe5dd5 100644
--- a/arch/arm/mach-mxs/mach-stmp378x_devb.c
+++ b/arch/arm/mach-mxs/mach-stmp378x_devb.c
@@ -19,7 +19,6 @@
 
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-#include <linux/irq.h>
 #include <linux/spi/spi.h>
 
 #include <asm/mach-types.h>
-- 
1.6.0.4
