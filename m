From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 26 Apr 2016 20:57:37 +0800
Subject: [RESEND PATCH v2 4/7] usb: xhci: plat: sort the headers in alphabetic
 order
In-Reply-To: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
Message-ID: <1461675460-2295-5-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorting the headers in alphabetic order will help to reduce the conflict
when adding new headers later.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/usb/host/xhci-plat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index fbd23fd..0e69712 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -11,19 +11,19 @@
  * version 2 as published by the Free Software Foundation.
  */
 
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/usb/phy.h>
 #include <linux/slab.h>
+#include <linux/usb/phy.h>
 #include <linux/usb/xhci_pdriver.h>
-#include <linux/acpi.h>
 
 #include "xhci.h"
-#include "xhci-plat.h"
 #include "xhci-mvebu.h"
+#include "xhci-plat.h"
 #include "xhci-rcar.h"
 
 static struct hc_driver __read_mostly xhci_plat_hc_driver;
-- 
2.8.1
