From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue,  3 Apr 2012 09:32:55 +0200
Subject: [PATCH v2 11/13] USB: ehci-atmel: add needed of.h header file
In-Reply-To: <cover.1333437885.git.nicolas.ferre@atmel.com>
References: <cover.1333437885.git.nicolas.ferre@atmel.com>
Message-ID: <854005fd9291e0c02d6ddd24176e77f58ed073b8.1333437885.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compilation error in case of non-DT configuration without this
of.h header file.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/usb/host/ehci-atmel.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index 19f318a..cf14c95 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -13,6 +13,7 @@
 
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 
 /* interface and function clocks */
-- 
1.7.9.4
