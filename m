From: t.remmet@phytec.de (Teresa Remmet)
Date: Tue, 24 Jan 2017 11:09:36 +0100
Subject: [PATCH v2 3/3] ARM: configs: omap2plus_defconfig: Enable support for
 RTC M41T80
In-Reply-To: <1485252576-36955-1-git-send-email-t.remmet@phytec.de>
References: <1485252576-36955-1-git-send-email-t.remmet@phytec.de>
Message-ID: <1485252576-36955-3-git-send-email-t.remmet@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phyCORE-AM335x SoM has a RV4162 RTC populated which is supported
by the M41T80 driver. Enabled it so make the RTC support on the SoM
available.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 0c2bf2d..75b5b73 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -414,6 +414,7 @@ CONFIG_LEDS_TRIGGER_GPIO=m
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=m
+CONFIG_RTC_DRV_M41T80=m
 CONFIG_RTC_DRV_TWL92330=y
 CONFIG_RTC_DRV_TWL4030=m
 CONFIG_RTC_DRV_PALMAS=m
-- 
1.9.1
