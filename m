From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 25 Sep 2012 10:56:01 +0200
Subject: [RESEND PATCH] rtc: kconfig: Fixup dependency for ab8500
Message-ID: <1348563361-4395-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/rtc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 9476456..e069f17 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -738,6 +738,7 @@ config RTC_DRV_AB3100
 config RTC_DRV_AB8500
 	tristate "ST-Ericsson AB8500 RTC"
 	depends on AB8500_CORE
+	select RTC_INTF_DEV
 	select RTC_INTF_DEV_UIE_EMUL
 	help
 	  Select this to enable the ST-Ericsson AB8500 power management IC RTC
-- 
1.7.10
