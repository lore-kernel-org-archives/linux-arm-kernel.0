From: jdzheng@broadcom.com (JD (Jiandong) Zheng)
Date: Tue, 15 Jun 2010 13:42:26 -0700
Subject: [PATCH] MAINTAINERS: Change BCMRING maintainer
Message-ID: <8628FE4E7912BF47A96AE7DD7BAC0AADDDC694E3F7@SJEXCHCCR02.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am Jiandong Zheng working on BCMRING in Broadcom Canada Ltd. I am replacing Leo Chen (leochen at broadcom.com) as " ARM/BCMRING ARM ARCHITECTURE" and "ARM/BCMRING MTD NAND DRIVER" maintainer.

Here is the patch to MAINTAINERS file in linux 2.6.34 about this change.

Signed-off-by: Jiandong Zheng <jdzheng@broadcom.com>

diff -urN linux-2.6.34/MAINTAINERS.orig linux-2.6.34/MAINTAINERS
--- linux-2.6.34/MAINTAINERS.orig	2010-06-15 11:59:53.202128994 -0700
+++ linux-2.6.34/MAINTAINERS	2010-06-15 12:01:59.862277620 -0700
@@ -570,14 +570,14 @@
 S:	Maintained
 
 ARM/BCMRING ARM ARCHITECTURE
-M:	Leo Chen <leochen@broadcom.com>
+M:	Jiandong Zheng <jdzheng@broadcom.com>
 M:	Scott Branden <sbranden@broadcom.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-bcmring
 
 ARM/BCMRING MTD NAND DRIVER
-M:	Leo Chen <leochen@broadcom.com>
+M:	Jiandong Zheng <jdzheng@broadcom.com>
 M:	Scott Branden <sbranden@broadcom.com>
 L:	linux-mtd at lists.infradead.org
 S:	Maintained


Thanks,

Jiandong Zheng
Senior Staff Software Engineer
Broadcom Canada Ltd.
