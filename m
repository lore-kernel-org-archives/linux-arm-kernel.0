From: stigge@antcom.de (Roland Stigge)
Date: Thu, 18 Oct 2012 18:06:08 +0200
Subject: [PATCH 1/2] rtc-imxdi: Support for i.MX53
Message-ID: <1350576370-29098-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables support for i.MX53 in addition to i.MX25 by enabling the
driver on ARCH_MXC generally.

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 drivers/rtc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/drivers/rtc/Kconfig
+++ linux-2.6/drivers/rtc/Kconfig
@@ -768,7 +768,7 @@ config RTC_DRV_DAVINCI
 
 config RTC_DRV_IMXDI
 	tristate "Freescale IMX DryIce Real Time Clock"
-	depends on SOC_IMX25
+	depends on ARCH_MXC
 	help
 	   Support for Freescale IMX DryIce RTC
 
