From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 9 Oct 2009 14:35:14 -0400
Subject: [PATCH] CPU_ARM920T: remove dead Maverick EP9312 URL
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7DBA@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the URL listed for Maverick EP9312 since it is not available
and modify the help text appropriately.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index e993140..9264d81 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -122,10 +122,7 @@ config CPU_ARM920T
 	select CPU_TLB_V4WBI if MMU
 	help
 	  The ARM920T is licensed to be produced by numerous vendors,
-	  and is used in the Maverick EP9312 and the Samsung S3C2410.
-
-	  More information on the Maverick EP9312 at
-	  <http://linuxdevices.com/products/PD2382866068.html>.
+	  and is used in the Cirrus EP93xx and the Samsung S3C2410.
 
 	  Say Y if you want support for the ARM920T processor.
 	  Otherwise, say N. 
