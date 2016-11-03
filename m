From: ahaslam@baylibre.com (Axel Haslam)
Date: Thu,  3 Nov 2016 17:03:08 +0100
Subject: [PATCH v2 3/3] usb: ohci-da8xx: rename driver to ohci-da8xx
In-Reply-To: <20161103160308.29588-1-ahaslam@baylibre.com>
References: <20161103160308.29588-1-ahaslam@baylibre.com>
Message-ID: <20161103160308.29588-4-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci ohci driver name (currently "ohci") is too generic.
To be consistent with other usb dirvers, append the "-da8xx" postfix
to the name.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/usb/host/ohci-da8xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 30c4878..429d58b 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -27,7 +27,7 @@
 #include "ohci.h"
 
 #define DRIVER_DESC "DA8XX"
-#define DRV_NAME "ohci"
+#define DRV_NAME "ohci-da8xx"
 
 static struct hc_driver __read_mostly ohci_da8xx_hc_driver;
 
-- 
2.10.1
