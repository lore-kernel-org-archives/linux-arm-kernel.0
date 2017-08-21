From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 21 Aug 2017 13:11:32 +0530
Subject: [PATCH 5/5] MAINTAINERS: Add TI OMAP SDHCI Maintainer
In-Reply-To: <20170821074132.4622-1-kishon@ti.com>
References: <20170821074132.4622-1-kishon@ti.com>
Message-ID: <20170821074132.4622-6-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Maintainer for the TI OMAP SDHCI driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44cb004c765d..c9871351c16f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11777,6 +11777,12 @@ L:	linux-mmc at vger.kernel.org
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
