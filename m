From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 14 Dec 2012 11:33:17 +0530
Subject: [PATCH v4 4/4] ARM: OMAP2+: omap2plus_defconfig: Enable RTC support
In-Reply-To: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
References: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
Message-ID: <1355464997-19367-5-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM33XX family of devices use RTC module, one has to manually enable
this support to use RTC features. So this patch enable RTC driver in
omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 0ce6771..e58afc5 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -216,6 +216,7 @@ CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_OMAP=y
 CONFIG_RTC_DRV_TWL92330=y
 CONFIG_RTC_DRV_TWL4030=y
 CONFIG_DMADEVICES=y
-- 
1.7.9.5
