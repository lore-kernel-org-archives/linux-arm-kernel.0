From: stigge@antcom.de (stigge at antcom.de)
Date: Thu,  2 Feb 2012 20:19:44 +0100
Subject: [PATCH v3 3/7] ARM: LPC32xx: clock.c: Missing header file
In-Reply-To: <1328210388-21296-1-git-send-email-stigge@antcom.de>
References: <1328210388-21296-1-git-send-email-stigge@antcom.de>
Message-ID: <1328210388-21296-3-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the compiler warnings regarding the EXPORT_SYMBOL usage

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>

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
