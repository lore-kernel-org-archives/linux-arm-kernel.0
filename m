From: vaibhav.bedia@ti.com (Vaibhav Bedia)
Date: Mon, 31 Dec 2012 18:36:57 +0530
Subject: [RFC v2 04/18] ARM: OMAP2+: AM33XX: CM: Get rid of unncessary header
 inclusions
In-Reply-To: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <1356959231-17335-5-git-send-email-vaibhav.bedia@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the included header files are not needed so
remove them.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
---
v1->v2:
	This is a new patch in the series based on
	Santosh's feedback on splitting the changes

 arch/arm/mach-omap2/cm33xx.h |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 5fa0b62..8009e13 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -17,16 +17,11 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CM_33XX_H
 #define __ARCH_ARM_MACH_OMAP2_CM_33XX_H
 
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/io.h>
-
 #include "common.h"
 
 #include "cm.h"
 #include "cm-regbits-33xx.h"
-#include "cm33xx.h"
+#include "iomap.h"
 
 /* CM base address */
 #define AM33XX_CM_BASE		0x44e00000
-- 
1.7.0.4
