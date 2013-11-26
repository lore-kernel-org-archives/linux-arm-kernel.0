From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Nov 2013 16:32:09 +0900
Subject: [PATCH RFC v2 07/17] ARM: shmobile: r8a7779: Sort headers
 alphabetically
In-Reply-To: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
References: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1385451139-29686-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 4f9e3ec..e202c64 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -19,35 +19,35 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/kernel.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/traps.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/leds.h>
-#include <linux/dma-mapping.h>
+#include <linux/mfd/tmio.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/camera-rcar.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/rcar-du.h>
 #include <linux/platform_data/usb-rcar-phy.h>
+#include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
-#include <linux/spi/spi.h>
 #include <linux/spi/sh_hspi.h>
-#include <linux/mmc/host.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
-#include <linux/mfd/tmio.h>
-#include <media/soc_camera.h>
-#include <mach/r8a7779.h>
+#include <linux/spi/spi.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/traps.h>
+#include <mach/r8a7779.h>
+#include <media/soc_camera.h>
 
 /* Fixed 3.3V regulator to be used by SDHI0 */
 static struct regulator_consumer_supply fixed3v3_power_consumers[] = {
-- 
1.8.4
