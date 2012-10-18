From: zonque@gmail.com (Daniel Mack)
Date: Thu, 18 Oct 2012 17:53:49 +0200
Subject: [PATCH 1/3] RTC: omap-rtc: enable for SOC_AM33XX
Message-ID: <1350575631-15523-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The same IP is found on AM33xx as well, so let users select it.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 19c03ab..5cb5be7 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -777,7 +777,7 @@ config RTC_DRV_IMXDI
 
 config RTC_DRV_OMAP
 	tristate "TI OMAP1"
-	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX
+	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX || SOC_AM33XX
 	help
 	  Say "yes" here to support the real time clock on TI OMAP1 and
 	  DA8xx/OMAP-L13x chips.  This driver can also be built as a
-- 
1.7.11.7
