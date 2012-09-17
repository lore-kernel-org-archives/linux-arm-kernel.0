From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Sep 2012 13:34:33 +0800
Subject: [PATCH 04/34] ARM: imx: remove unnecessary inclusion from
 device-imx*.h
In-Reply-To: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1347860103-4141-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need for device-imx*.h to include <soc>.h.  Remove them
and fix one indirect inclusion in mach-mx31ads.c.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/devices-imx1.h  |    1 -
 arch/arm/mach-imx/devices-imx21.h |    1 -
 arch/arm/mach-imx/devices-imx25.h |    1 -
 arch/arm/mach-imx/devices-imx27.h |    1 -
 arch/arm/mach-imx/devices-imx31.h |    1 -
 arch/arm/mach-imx/devices-imx35.h |    1 -
 arch/arm/mach-imx/devices-imx50.h |    1 -
 arch/arm/mach-imx/devices-imx51.h |    1 -
 arch/arm/mach-imx/mach-mx31ads.c  |    1 +
 9 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/devices-imx1.h b/arch/arm/mach-imx/devices-imx1.h
index 3aad1e7..eb2603b 100644
--- a/arch/arm/mach-imx/devices-imx1.h
+++ b/arch/arm/mach-imx/devices-imx1.h
@@ -6,7 +6,6 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/mx1.h>
 #include <mach/devices-common.h>
 
 extern const struct imx_imx_fb_data imx1_imx_fb_data;
diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index 93ece55..e2014da 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -6,7 +6,6 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/mx21.h>
 #include <mach/devices-common.h>
 
 extern const struct imx_imx21_hcd_data imx21_imx21_hcd_data;
diff --git a/arch/arm/mach-imx/devices-imx25.h b/arch/arm/mach-imx/devices-imx25.h
index f8e03dd..29e9706 100644
--- a/arch/arm/mach-imx/devices-imx25.h
+++ b/arch/arm/mach-imx/devices-imx25.h
@@ -6,7 +6,6 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/mx25.h>
 #include <mach/devices-common.h>
 
 extern const struct imx_fec_data imx25_fec_data;
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 436c572..1c85b57 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -6,7 +6,6 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/mx27.h>
 #include <mach/devices-common.h>
 
 extern const struct imx_fec_data imx27_fec_data;
diff --git a/arch/arm/mach-imx/devices-imx31.h b/arch/arm/mach-imx/devices-imx31.h
index 8b2ceb4..20565f9 100644
--- a/arch/arm/mach-imx/devices-imx31.h
+++ b/arch/arm/mach-imx/devices-imx31.h
@@ -6,7 +6,6 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/mx31.h>
 #include <mach/devices-common.h>
 
 extern const struct imx_fsl_usb2_udc_data imx31_fsl_usb2_udc_data;
diff --git a/arch/arm/mach-imx/devices-imx35.h b/arch/arm/mach-imx/devices-imx35.h
index c3e9f20..e45b5cb 100644
--- a/arch/arm/mach-imx/devices-imx35.h
+++ b/arch/arm/mach-imx/devices-imx35.h
@@ -6,7 +6,6 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/mx35.h>
 #include <mach/devices-common.h>
 
 extern const struct imx_fec_data imx35_fec_data;
diff --git a/arch/arm/mach-imx/devices-imx50.h b/arch/arm/mach-imx/devices-imx50.h
index 7216667..1615a6a 100644
--- a/arch/arm/mach-imx/devices-imx50.h
+++ b/arch/arm/mach-imx/devices-imx50.h
@@ -18,7 +18,6 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#include <mach/mx50.h>
 #include <mach/devices-common.h>
 
 extern const struct imx_imx_uart_1irq_data imx50_imx_uart_data[];
diff --git a/arch/arm/mach-imx/devices-imx51.h b/arch/arm/mach-imx/devices-imx51.h
index 9f17187..f448104 100644
--- a/arch/arm/mach-imx/devices-imx51.h
+++ b/arch/arm/mach-imx/devices-imx51.h
@@ -6,7 +6,6 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/mx51.h>
 #include <mach/devices-common.h>
 
 extern const struct imx_fec_data imx51_fec_data;
diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index 3d95d03..156a23e 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -29,6 +29,7 @@
 #include <asm/memory.h>
 #include <asm/mach/map.h>
 #include <mach/common.h>
+#include <mach/hardware.h>
 
 #ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
 #include <linux/mfd/wm8350/audio.h>
-- 
1.7.9.5
