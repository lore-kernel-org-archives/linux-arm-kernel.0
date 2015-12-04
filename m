From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 4 Dec 2015 22:10:49 +0800
Subject: [PATCH 4/7] usb: xhci: plat: sort the headers in alphabetic order
In-Reply-To: <1449238252-5630-1-git-send-email-jszhang@marvell.com>
References: <1449238252-5630-1-git-send-email-jszhang@marvell.com>
Message-ID: <1449238252-5630-5-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorting the headers in alphabetic order will help to reduce the conflict
when adding new headers later.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/usb/host/xhci-plat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index cd49ae5..d990135 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -11,15 +11,15 @@
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
 #include "xhci-mvebu.h"
-- 
2.6.2
