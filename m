From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  1 Aug 2011 11:38:23 +0200
Subject: [PATCH 2/8] ARM: mx5: remove unused #includes of devices.h
In-Reply-To: <1312191509-21895-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110801093759.GD9250@pengutronix.de>
	<1312191509-21895-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1312191509-21895-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/board-mx51_3ds.c           |    1 -
 arch/arm/mach-mx5/board-mx51_efikamx.c       |    1 -
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |    1 -
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c |    1 -
 4 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index 07a3815..e5db7c1 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -25,7 +25,6 @@
 #include <mach/3ds_debugboard.h>
 
 #include "devices-imx51.h"
-#include "devices.h"
 
 #define EXPIO_PARENT_INT	gpio_to_irq(IMX_GPIO_NR(1, 6))
 #define MX51_3DS_ECSPI2_CS	(GPIO_PORTC + 28)
diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
index f70700d..43ac100 100644
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -39,7 +39,6 @@
 #include <asm/mach/time.h>
 
 #include "devices-imx51.h"
-#include "devices.h"
 #include "efika.h"
 
 #define EFIKAMX_PCBID0		IMX_GPIO_NR(3, 16)
diff --git a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
index bbf4564..72ce755 100644
--- a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
@@ -28,7 +28,6 @@
 #include <asm/mach/arch.h>
 
 #include "devices-imx51.h"
-#include "devices.h"
 
 #define MBIMX51_TSC2007_GPIO	IMX_GPIO_NR(3, 30)
 #define MBIMX51_LED0		IMX_GPIO_NR(3, 5)
diff --git a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
index 2619239..90f5c9c 100644
--- a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
@@ -41,7 +41,6 @@
 #include <mach/audmux.h>
 
 #include "devices-imx51.h"
-#include "devices.h"
 
 static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 	/* LED */
-- 
1.7.5.4
