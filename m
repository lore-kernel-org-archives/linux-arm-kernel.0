From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 7 May 2014 13:20:45 +0300
Subject: [PATCH v2 1/4] ARM: dts: dra7xx-clocks: Correct name for atl clkin3
 clock
In-Reply-To: <1399458048-28213-1-git-send-email-peter.ujfalusi@ti.com>
References: <1399458048-28213-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1399458048-28213-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allign the name with the other atl clock names:
atlclkin3_ck -> atl_clkin3_ck

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 22 +++++++++++-----------
 drivers/clk/ti/clk-7xx.c             |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index cfb8fc753f50..30160348934c 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -26,7 +26,7 @@
 		clock-frequency = <0>;
 	};
 
-	atlclkin3_ck: atlclkin3_ck {
+	atl_clkin3_ck: atl_clkin3_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <0>;
@@ -730,7 +730,7 @@
 	mcasp1_ahclkr_mux: mcasp1_ahclkr_mux {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
 		ti,bit-shift = <28>;
 		reg = <0x0550>;
 	};
@@ -738,7 +738,7 @@
 	mcasp1_ahclkx_mux: mcasp1_ahclkx_mux {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
 		ti,bit-shift = <24>;
 		reg = <0x0550>;
 	};
@@ -1631,7 +1631,7 @@
 	mcasp2_ahclkr_mux: mcasp2_ahclkr_mux {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
 		ti,bit-shift = <28>;
 		reg = <0x1860>;
 	};
@@ -1639,7 +1639,7 @@
 	mcasp2_ahclkx_mux: mcasp2_ahclkx_mux {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
 		ti,bit-shift = <24>;
 		reg = <0x1860>;
 	};
@@ -1655,7 +1655,7 @@
 	mcasp3_ahclkx_mux: mcasp3_ahclkx_mux {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
 		ti,bit-shift = <24>;
 		reg = <0x1868>;
 	};
@@ -1671,7 +1671,7 @@
 	mcasp4_ahclkx_mux: mcasp4_ahclkx_mux {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
 		ti,bit-shift = <24>;
 		reg = <0x1898>;
 	};
@@ -1687,7 +1687,7 @@
 	mcasp5_ahclkx_mux: mcasp5_ahclkx_mux {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
 		ti,bit-shift = <24>;
 		reg = <0x1878>;
 	};
@@ -1703,7 +1703,7 @@
 	mcasp6_ahclkx_mux: mcasp6_ahclkx_mux {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
 		ti,bit-shift = <24>;
 		reg = <0x1904>;
 	};
@@ -1719,7 +1719,7 @@
 	mcasp7_ahclkx_mux: mcasp7_ahclkx_mux {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
 		ti,bit-shift = <24>;
 		reg = <0x1908>;
 	};
@@ -1735,7 +1735,7 @@
 	mcasp8_ahclk_mux: mcasp8_ahclk_mux {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
 		ti,bit-shift = <22>;
 		reg = <0x1890>;
 	};
diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index 19a55bf407dd..cb8e6f14e880 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -24,7 +24,7 @@ static struct ti_dt_clk dra7xx_clks[] = {
 	DT_CLK(NULL, "atl_clkin0_ck", "atl_clkin0_ck"),
 	DT_CLK(NULL, "atl_clkin1_ck", "atl_clkin1_ck"),
 	DT_CLK(NULL, "atl_clkin2_ck", "atl_clkin2_ck"),
-	DT_CLK(NULL, "atlclkin3_ck", "atlclkin3_ck"),
+	DT_CLK(NULL, "atl_clkin3_ck", "atl_clkin3_ck"),
 	DT_CLK(NULL, "hdmi_clkin_ck", "hdmi_clkin_ck"),
 	DT_CLK(NULL, "mlb_clkin_ck", "mlb_clkin_ck"),
 	DT_CLK(NULL, "mlbp_clkin_ck", "mlbp_clkin_ck"),
-- 
1.9.2
