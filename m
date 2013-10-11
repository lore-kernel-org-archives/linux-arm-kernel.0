From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 11 Oct 2013 17:57:05 +0800
Subject: [PATCH] ARM: tegra: enable Tegra RTC as default for Tegra124
Message-ID: <1381485425-3354-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes the Tegra RTC enabled as default for Tegra124 platform.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
Note:
This patch was based on the patch "ARM: tegra: add clock properties for
devices of Tegra124" that already queued in linux-tegra.
---
 arch/arm/boot/dts/tegra124.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 7862024..2207555 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -94,7 +94,6 @@
 		compatible = "nvidia,tegra124-rtc", "nvidia,tegra20-rtc";
 		reg = <0x7000e000 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
 		clocks = <&tegra_car TEGRA124_CLK_RTC>;
 	};
 
-- 
1.8.4
