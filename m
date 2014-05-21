From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 21 May 2014 15:16:10 +0300
Subject: [PATCH 1/2] ARM: dts: omap5-clocks.dtsi: add ti,
 set-rate-parent to dss_dss_clk
Message-ID: <1400674571-633-1-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ti,set-rate-parent to dss_dss_clk so that the DSS driver can
set the rate.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap54xx-clocks.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index d487fdab3921..d44bdaa8fe68 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -851,6 +851,7 @@
 		clocks = <&dpll_per_h12x2_ck>;
 		ti,bit-shift = <8>;
 		reg = <0x1420>;
+		ti,set-rate-parent;
 	};
 
 	dss_sys_clk: dss_sys_clk {
-- 
1.9.1
