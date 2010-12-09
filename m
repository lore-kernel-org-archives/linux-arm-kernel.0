From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 9 Dec 2010 15:24:17 +0100
Subject: [PATCH v2 2/2] OMAP: serial: Change device name: omap-hsuart ->
	omap_uart
In-Reply-To: <1291904657-32729-1-git-send-email-b-cousson@ti.com>
References: <1291904657-32729-1-git-send-email-b-cousson@ti.com>
Message-ID: <1291904657-32729-3-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The naming convention for omap_device is omap_XXX.

Rename the device and driver name in order to stick
to this naming convention.
Remove the hs prefix that is implicit for every OMAP uarts.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Govindraj Raja <govindraj.raja@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/plat/omap-serial.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index c8dae02..cc71426 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -22,7 +22,7 @@
 
 #include <plat/mux.h>
 
-#define DRIVER_NAME	"omap-hsuart"
+#define DRIVER_NAME	"omap_uart"
 
 /*
  * Use tty device name as ttyO, [O -> OMAP]
-- 
1.7.0.4
