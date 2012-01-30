From: stigge@antcom.de (Roland Stigge)
Date: Mon, 30 Jan 2012 17:02:00 +0100
Subject: [PATCH v2 1/7] LPC32xx: clock.c: Missing header file
Message-ID: <1327939327-7799-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the compiler warnings regarding the EXPORT_SYMBOL usage

Signed-off-by: Roland Stigge <stigge@antcom.de>

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 1e02751..8e79313 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -82,6 +82,7 @@
  *   will also impact the individual peripheral rates.
  */
 
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/errno.h>
