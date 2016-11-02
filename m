From: ahaslam@baylibre.com (Axel Haslam)
Date: Wed,  2 Nov 2016 13:44:35 +0100
Subject: [PATCH 3/3] usb: ohci-da8xx: rename driver to ohci-da8xx
In-Reply-To: <20161102124435.31777-1-ahaslam@baylibre.com>
References: <20161102124435.31777-1-ahaslam@baylibre.com>
Message-ID: <20161102124435.31777-4-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be consistent on the usb driver for the davinci
platform follow the example of musb, and add the
"-da8xx" postfix to the driver name.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/usb/host/ohci-da8xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index bd6cf3c..b3de8bc 100644
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
