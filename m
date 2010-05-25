From: tbm@cyrius.com (Martin Michlmayr)
Date: Tue, 25 May 2010 18:20:14 +0100
Subject: [PATCH] Kirkwood: Fix explanation of MPP45 for QNAP TS41x
Message-ID: <20100525172014.GA26474@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the QNAP TS-41x, MPP45 is used to show the setting of jumper JP1.
Fix the documentation to explain what the settings really indicate.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

--- a/arch/arm/mach-kirkwood/ts41x-setup.c	2010-05-24 14:22:37.000000000 +0000
+++ b/arch/arm/mach-kirkwood/ts41x-setup.c	2010-05-24 14:23:05.000000000 +0000
@@ -105,7 +105,7 @@
 	MPP37_GPIO,		/* Reset button */
 	MPP43_GPIO,		/* USB Copy button */
 	MPP44_GPIO,		/* Board ID: 0: TS-419U, 1: TS-419 */
-	MPP45_GPIO,		/* JP1: 0: console, 1: LCD */
+	MPP45_GPIO,		/* JP1: 0: LCD, 1: serial console */
 	MPP46_GPIO,		/* External SATA HDD1 error indicator */
 	MPP47_GPIO,		/* External SATA HDD2 error indicator */
 	MPP48_GPIO,		/* External SATA HDD3 error indicator */

-- 
Martin Michlmayr
http://www.cyrius.com/
