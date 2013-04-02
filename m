From: stigge@antcom.de (Roland Stigge)
Date: Tue,  2 Apr 2013 19:37:11 +0200
Subject: [PATCH] MAINTAINERS: Add maintainer for LPC32xx
Message-ID: <1364924231-18591-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Roland Stigge as maintainer for NXP LPC32xx.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.orig/MAINTAINERS
+++ linux-2.6/MAINTAINERS
@@ -4941,6 +4941,12 @@ W:	logfs.org
 S:	Maintained
 F:	fs/logfs/
 
+LPC32XX MACHINE SUPPORT
+M:	Roland Stigge <stigge@antcom.de>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-lpc32xx/
+
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Nagalakshmi Nandigama <Nagalakshmi.Nandigama@lsi.com>
 M:	Sreekanth Reddy <Sreekanth.Reddy@lsi.com>
