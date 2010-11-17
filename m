From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:54 +0100
Subject: [PATCH 26/51] ARM: imx: remove now empty devices.h
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-26-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices.c                  |    2 --
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    1 -
 arch/arm/mach-imx/mach-cpuimx27.c            |    1 -
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c  |    1 -
 arch/arm/mach-imx/mach-imx27lite.c           |    1 -
 arch/arm/mach-imx/mach-mx1ads.c              |    1 -
 arch/arm/mach-imx/mach-mx21ads.c             |    1 -
 arch/arm/mach-imx/mach-mx27_3ds.c            |    1 -
 arch/arm/mach-imx/mach-mx27ads.c             |    1 -
 arch/arm/mach-imx/mach-mxt_td60.c            |    1 -
 arch/arm/mach-imx/mach-pca100.c              |    1 -
 arch/arm/mach-imx/mach-pcm038.c              |    1 -
 arch/arm/mach-imx/mach-scb9328.c             |    1 -
 arch/arm/mach-imx/pcm970-baseboard.c         |    1 -
 14 files changed, 0 insertions(+), 15 deletions(-)
 delete mode 100644 arch/arm/mach-imx/devices.h

diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index 8fd2545..cfc6891 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -42,8 +42,6 @@
 #include <mach/common.h>
 #include <mach/mmc.h>
 
-#include "devices.h"
-
 #if defined(CONFIG_ARCH_MX1)
 /* GPIO port description */
 static struct mxc_gpio_port imx_gpio_ports[] = {
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
deleted file mode 100644
index e69de29..0000000
diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index 3aaa3b9..7dce251 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -36,7 +36,6 @@
 #include <mach/audmux.h>
 
 #include "devices-imx27.h"
-#include "devices.h"
 
 static const int eukrea_mbimx27_pins[] __initconst = {
 	/* UART2 */
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 9ae5bed..6cf04da 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -42,7 +42,6 @@
 #include <mach/ulpi.h>
 
 #include "devices-imx27.h"
-#include "devices.h"
 
 static const int eukrea_cpuimx27_pins[] __initconst = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index c9f12e4..40a3666 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -37,7 +37,6 @@
 #include <mach/iomux.h>
 
 #include "devices-imx27.h"
-#include "devices.h"
 
 #define OTG_PHY_CS_GPIO (GPIO_PORTF + 17)
 #define SDHC1_IRQ IRQ_GPIOB(25)
diff --git a/arch/arm/mach-imx/mach-imx27lite.c b/arch/arm/mach-imx/mach-imx27lite.c
index bbdbc75..3a1202e 100644
--- a/arch/arm/mach-imx/mach-imx27lite.c
+++ b/arch/arm/mach-imx/mach-imx27lite.c
@@ -25,7 +25,6 @@
 #include <mach/iomux-mx27.h>
 
 #include "devices-imx27.h"
-#include "devices.h"
 
 static const int mx27lite_pins[] __initconst = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
index 6187ce9..1f446e5 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -30,7 +30,6 @@
 #include <mach/irqs.h>
 
 #include "devices-imx1.h"
-#include "devices.h"
 
 static const int mx1ads_pins[] __initconst = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index 83c064a..0a37257 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -28,7 +28,6 @@
 #include <mach/mxc_nand.h>
 
 #include "devices-imx21.h"
-#include "devices.h"
 
 /*
  * Memory-mapped I/O on MX21ADS base board
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 80399b2..3614e33 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -31,7 +31,6 @@
 #include <mach/iomux-mx27.h>
 
 #include "devices-imx27.h"
-#include "devices.h"
 
 #define SD1_EN_GPIO (GPIO_PORTB + 25)
 
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 370481b..b832f96 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -32,7 +32,6 @@
 #include <mach/mxc_nand.h>
 
 #include "devices-imx27.h"
-#include "devices.h"
 
 /*
  * Base address of PBC controller, CS4
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index d1a3158..4ce71b0 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -33,7 +33,6 @@
 #include <linux/i2c/pca953x.h>
 
 #include "devices-imx27.h"
-#include "devices.h"
 
 static const int mxt_td60_pins[] __initconst = {
 	/* UART0 */
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index d9e2dda..cccc0a0 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -42,7 +42,6 @@
 #include <mach/ulpi.h>
 
 #include "devices-imx27.h"
-#include "devices.h"
 
 #define OTG_PHY_CS_GPIO (GPIO_PORTB + 23)
 #define USBH2_PHY_CS_GPIO (GPIO_PORTB + 24)
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index e209b28..f667a26 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -40,7 +40,6 @@
 #include <mach/ulpi.h>
 
 #include "devices-imx27.h"
-#include "devices.h"
 
 static const int pcm038_pins[] __initconst = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
index 1fbdd3f..eae878f 100644
--- a/arch/arm/mach-imx/mach-scb9328.c
+++ b/arch/arm/mach-imx/mach-scb9328.c
@@ -25,7 +25,6 @@
 #include <mach/iomux-mx1.h>
 
 #include "devices-imx1.h"
-#include "devices.h"
 
 /*
  * This scb9328 has a 32MiB flash
diff --git a/arch/arm/mach-imx/pcm970-baseboard.c b/arch/arm/mach-imx/pcm970-baseboard.c
index 1297f1b..99afbc3 100644
--- a/arch/arm/mach-imx/pcm970-baseboard.c
+++ b/arch/arm/mach-imx/pcm970-baseboard.c
@@ -28,7 +28,6 @@
 #include <mach/hardware.h>
 
 #include "devices-imx27.h"
-#include "devices.h"
 
 static const int pcm970_pins[] __initconst = {
 	/* SDHC */
-- 
1.7.2.3
