From: stigge@antcom.de (Roland Stigge)
Date: Wed,  8 Feb 2012 21:41:01 +0100
Subject: [PATCH v4 3/7] ARM: LPC32xx: clock.c: Missing header file
In-Reply-To: <1328733665-17836-1-git-send-email-stigge@antcom.de>
References: <1328733665-17836-1-git-send-email-stigge@antcom.de>
Message-ID: <1328733665-17836-4-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the compiler warnings regarding the EXPORT_SYMBOL usage

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Kevin Wells <kevin.wells@nxp.com>

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 1e02751..8e79313 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -82,6 +82,7 @@
  *   will also impact the individual peripheral rates.
  */
 
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/errno.h>
