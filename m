From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 11 Aug 2014 11:38:59 +0900
Subject: [PATCH] ARM: shmobile: armadillo800eva: Sort includes
Message-ID: <1407724739-14100-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorted includes seems to be the done thing these days.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 40 +++++++++++++-------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index fc73246..ad27665 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -22,43 +22,43 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/input.h>
-#include <linux/platform_data/st1232_pdata.h>
-#include <linux/irq.h>
-#include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
-#include <linux/regulator/driver.h>
+#include <linux/i2c-gpio.h>
+#include <linux/input.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/mfd/tmio.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/platform_data/st1232_pdata.h>
+#include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
+#include <linux/reboot.h>
+#include <linux/regulator/driver.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/gpio-regulator.h>
 #include <linux/regulator/machine.h>
 #include <linux/sh_eth.h>
-#include <linux/videodev2.h>
 #include <linux/usb/renesas_usbhs.h>
-#include <linux/mfd/tmio.h>
-#include <linux/mmc/host.h>
-#include <linux/mmc/sh_mmcif.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
-#include <linux/i2c-gpio.h>
-#include <linux/reboot.h>
+#include <linux/videodev2.h>
 
-#include <media/mt9t112.h>
-#include <media/sh_mobile_ceu.h>
-#include <media/soc_camera.h>
-#include <asm/page.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <asm/hardware/cache-l2x0.h>
-#include <video/sh_mobile_lcdc.h>
-#include <video/sh_mobile_hdmi.h>
+#include <asm/page.h>
+#include <media/mt9t112.h>
+#include <media/sh_mobile_ceu.h>
+#include <media/soc_camera.h>
 #include <sound/sh_fsi.h>
 #include <sound/simple_card.h>
+#include <video/sh_mobile_hdmi.h>
+#include <video/sh_mobile_lcdc.h>
 
 #include "common.h"
 #include "irqs.h"
-- 
2.0.1
