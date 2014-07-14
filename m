From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 Jul 2014 15:32:17 +0800
Subject: [PATCH 5/5] ARM: sunxi: Add A31 RTC driver to sunxi_defconfig
In-Reply-To: <1405323137-24287-1-git-send-email-wens@csie.org>
References: <1405323137-24287-1-git-send-email-wens@csie.org>
Message-ID: <1405323137-24287-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a driver for A31's RTC, enable it
in the default sunxi config.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 7209bfd..0abc2ab 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -93,6 +93,7 @@ CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_INTF_SYSFS is not set
 # CONFIG_RTC_INTF_PROC is not set
+CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_SUNXI=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_PHY_SUN4I_USB=y
-- 
2.0.1
