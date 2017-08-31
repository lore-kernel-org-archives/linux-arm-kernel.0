From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 31 Aug 2017 15:48:49 +0530
Subject: [PATCH v2 6/6] MAINTAINERS: Add TI OMAP SDHCI Maintainer
In-Reply-To: <20170831101849.9489-1-kishon@ti.com>
References: <20170831101849.9489-1-kishon@ti.com>
Message-ID: <20170831101849.9489-7-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Maintainer for the TI OMAP SDHCI driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c3feffb1c1c..e52af3b87404 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11776,6 +11776,12 @@ L:	linux-mmc at vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-spear.c
 
+SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) TI OMAP DRIVER
+M:	Kishon Vijay Abraham I <kishon@ti.com>
+L:	linux-mmc at vger.kernel.org
+S:	Maintained
+F:	drivers/mmc/host/sdhci-omap.c
+
 SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
 M:	Scott Bauer <scott.bauer@intel.com>
 M:	Jonathan Derrick <jonathan.derrick@intel.com>
-- 
2.11.0
