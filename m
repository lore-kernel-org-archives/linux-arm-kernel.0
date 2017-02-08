From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Wed,  8 Feb 2017 23:07:15 +0100 (CET)
Subject: [PATCH 1/4] ARM: sunxi_defconfig: Enable AC100 RTC driver
Message-ID: <937914a68e4e7d6db2d12540cc6253b200978e2d.1486590875.git.rask@formelder.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the AC100 RTC driver so boards with it can keep track of time.

Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/sunxi_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index da92c25..5cd5dd70 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -87,6 +87,7 @@ CONFIG_THERMAL_OF=y
 CONFIG_CPU_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
+CONFIG_MFD_AC100=y
 CONFIG_MFD_AXP20X=y
 CONFIG_MFD_AXP20X_I2C=y
 CONFIG_MFD_AXP20X_RSB=y
@@ -129,6 +130,7 @@ CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_INTF_SYSFS is not set
 # CONFIG_RTC_INTF_PROC is not set
+CONFIG_RTC_DRV_AC100=y
 CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_SUNXI=y
 CONFIG_DMADEVICES=y
-- 
2.10.2
