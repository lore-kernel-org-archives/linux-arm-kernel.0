From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Jun 2012 13:59:44 +0800
Subject: [PATCH 13/16] ARM: imx: remove unneeded mach/irq.h inclusion
In-Reply-To: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1339653587-4832-14-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unneeded mach/irq.h inclusion from imx platform code.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-apf9328.c  |    1 -
 arch/arm/mach-imx/mach-mx1ads.c   |    1 -
 arch/arm/mach-imx/mach-mx27_3ds.c |    1 -
 arch/arm/mach-imx/mach-mx31lite.c |    1 -
 arch/arm/mach-imx/mach-mx35_3ds.c |    1 -
 arch/arm/mach-imx/mach-pca100.c   |    1 -
 arch/arm/mach-imx/mach-qong.c     |    1 -
 arch/arm/mach-imx/mach-scb9328.c  |    1 -
 arch/arm/mach-imx/mach-vpr200.c   |    1 -
 arch/arm/mach-imx/mm-imx1.c       |    1 -
 arch/arm/mach-imx/mm-imx21.c      |    1 -
 arch/arm/mach-imx/mm-imx25.c      |    1 -
 arch/arm/mach-imx/mm-imx27.c      |    1 -
 arch/arm/mach-imx/mm-imx3.c       |    1 -
 14 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-imx/mach-apf9328.c b/arch/arm/mach-imx/mach-apf9328.c
index 5062fcb..7b99a79 100644
--- a/arch/arm/mach-imx/mach-apf9328.c
+++ b/arch/arm/mach-imx/mach-apf9328.c
@@ -27,7 +27,6 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/irqs.h>
 #include <mach/iomux-mx1.h>
 
 #include "devices-imx1.h"
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
index 7274e79..667f359 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -26,7 +26,6 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx1.h>
-#include <mach/irqs.h>
 
 #include "devices-imx1.h"
 
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index eeff0b6..71f7c58 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -40,7 +40,6 @@
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>
 #include <mach/ulpi.h>
-#include <mach/irqs.h>
 #include <mach/3ds_debugboard.h>
 
 #include "devices-imx27.h"
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index 4977378..c8785b3 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -43,7 +43,6 @@
 #include <mach/common.h>
 #include <mach/board-mx31lite.h>
 #include <mach/iomux-mx3.h>
-#include <mach/irqs.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index 596f237..e785254 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -46,7 +46,6 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx35.h>
-#include <mach/irqs.h>
 #include <mach/3ds_debugboard.h>
 #include <video/platform_lcd.h>
 
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 8b1dfa2..d620a95 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -36,7 +36,6 @@
 #include <mach/hardware.h>
 #include <mach/iomux-mx27.h>
 #include <asm/mach/time.h>
-#include <mach/irqs.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx27.h"
diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
index b6f11d2..39ceb8c 100644
--- a/arch/arm/mach-imx/mach-qong.c
+++ b/arch/arm/mach-imx/mach-qong.c
@@ -22,7 +22,6 @@
 #include <linux/gpio.h>
 
 #include <mach/hardware.h>
-#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
index 5001164..67ff38e 100644
--- a/arch/arm/mach-imx/mach-scb9328.c
+++ b/arch/arm/mach-imx/mach-scb9328.c
@@ -22,7 +22,6 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/irqs.h>
 #include <mach/iomux-mx1.h>
 
 #include "devices-imx1.h"
diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index 1aa5622..09864bb 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -31,7 +31,6 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx35.h>
-#include <mach/irqs.h>
 
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
index fcafd3d..6d60d51 100644
--- a/arch/arm/mach-imx/mm-imx1.c
+++ b/arch/arm/mach-imx/mm-imx1.c
@@ -24,7 +24,6 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/irqs.h>
 #include <mach/iomux-v1.h>
 
 static struct map_desc imx_io_desc[] __initdata = {
diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index 5f43905..d056dad 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -26,7 +26,6 @@
 #include <mach/devices-common.h>
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
-#include <mach/irqs.h>
 #include <mach/iomux-v1.h>
 
 /* MX21 memory map definition */
diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
index 6ff3714..388928f 100644
--- a/arch/arm/mach-imx/mm-imx25.c
+++ b/arch/arm/mach-imx/mm-imx25.c
@@ -29,7 +29,6 @@
 #include <mach/hardware.h>
 #include <mach/mx25.h>
 #include <mach/iomux-v3.h>
-#include <mach/irqs.h>
 
 /*
  * This table defines static virtual address mappings for I/O regions.
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index 2566255..e7e24af 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -26,7 +26,6 @@
 #include <mach/devices-common.h>
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
-#include <mach/irqs.h>
 #include <mach/iomux-v1.h>
 
 /* MX27 memory map definition */
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 967ed5b..3ccd167 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -30,7 +30,6 @@
 #include <mach/devices-common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-v3.h>
-#include <mach/irqs.h>
 
 #include "crmregs-imx3.h"
 
-- 
1.7.5.4
