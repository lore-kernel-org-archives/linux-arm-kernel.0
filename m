From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 9 May 2014 14:56:16 +0300
Subject: [PATCH 08/11] ARM: dts: omap5-clocks.dtsi: add ti,
 set-rate-parent to dss_dss_clk
In-Reply-To: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1399636579-8062-9-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ti,set-rate-parent to dss_dss_clk so that the DSS driver can
set the rate.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap54xx-clocks.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index 26c02f9e92c4..b53ca885c021 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -859,6 +859,7 @@
 		clocks = <&dpll_per_h12x2_ck>;
 		ti,bit-shift = <8>;
 		reg = <0x1420>;
+		ti,set-rate-parent;
 	};
 
 	dss_sys_clk: dss_sys_clk {
-- 
1.9.1
