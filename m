From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 29 Aug 2018 16:31:47 +0200
Subject: [PATCH 11/11] MAINTAINERS: sdhci: move the Microchip entry to proper
 location
In-Reply-To: <cover.1535552609.git.nicolas.ferre@microchip.com>
References: <cover.1535552609.git.nicolas.ferre@microchip.com>
Message-ID: <a0db2ae9552536582cf154bc8b4cdf2a023d2700.1535552609.git.nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All SDHCI controller drivers are gathered at the same place, add the
Microchip one there.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 78044223d90f..df2f61548308 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2483,12 +2483,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/input/atmel,maxtouch.txt
 F:	drivers/input/touchscreen/atmel_mxt_ts.c
 
-ATMEL SDMMC DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-L:	linux-mmc at vger.kernel.org
-S:	Supported
-F:	drivers/mmc/host/sdhci-of-at91.c
-
 ATMEL WIRELESS DRIVER
 M:	Simon Kelley <simon@thekelleys.org.uk>
 L:	linux-wireless at vger.kernel.org
@@ -13006,6 +13000,12 @@ L:	linux-mmc at vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-pci-dwc-mshc.c
 
+SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+L:	linux-mmc at vger.kernel.org
+S:	Supported
+F:	drivers/mmc/host/sdhci-of-at91.c
+
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER
 M:	Ben Dooks <ben-linux@fluff.org>
 M:	Jaehoon Chung <jh80.chung@samsung.com>
-- 
2.17.1
