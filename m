From: stigge@antcom.de (Roland Stigge)
Date: Wed, 18 Jul 2012 14:06:50 +0200
Subject: [PATCH 3/4] ARM: LPC32xx: Add PWM support
In-Reply-To: <1342613211-13190-1-git-send-email-stigge@antcom.de>
References: <1342613211-13190-1-git-send-email-stigge@antcom.de>
Message-ID: <1342613211-13190-4-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

This SoC has two PWM channels

Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.orig/arch/arm/Kconfig
+++ linux-2.6/arch/arm/Kconfig
@@ -567,6 +567,7 @@ config ARCH_LPC32XX
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	select USE_OF
+	select HAVE_PWM
 	help
 	  Support for the NXP LPC32XX family of processors
 
