From: george.cherian@ti.com (George Cherian)
Date: Fri, 2 May 2014 12:02:04 +0530
Subject: [PATCH v2 6/6] ARM: dts: am4372: Add clock names for cpsw and cpts
In-Reply-To: <1399012324-20737-1-git-send-email-george.cherian@ti.com>
References: <1399012324-20737-1-git-send-email-george.cherian@ti.com>
Message-ID: <1399012324-20737-7-git-send-email-george.cherian@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CPSW fck and CPTS clock and clock names for AM4372

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 36d523a..c2779f6 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -489,6 +489,8 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ti,hwmods = "cpgmac0";
+			clocks = <&cpsw_125mhz_gclk>, <&cpsw_cpts_rft_clk>;
+			clock-names = "fck", "cpts";
 			status = "disabled";
 			cpdma_channels = <8>;
 			ale_entries = <1024>;
-- 
1.8.3.1
