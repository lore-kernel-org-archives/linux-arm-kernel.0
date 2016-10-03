From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Mon, 3 Oct 2016 18:33:18 +0530
Subject: [PATCH v2 4/4] ARM: dts: am4372: add DMA properties for tscadc
In-Reply-To: <20161003130318.12591-1-mugunthanvnm@ti.com>
References: <20161003130318.12591-1-mugunthanvnm@ti.com>
Message-ID: <20161003130318.12591-5-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DMA properties for tscadc

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 0fadae5..6094d17 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -867,6 +867,8 @@
 			clocks = <&adc_tsc_fck>;
 			clock-names = "fck";
 			status = "disabled";
+			dmas = <&edma 53 0>, <&edma 57 0>;
+			dma-names = "fifo0", "fifo1";
 
 			tsc {
 				compatible = "ti,am3359-tsc";
-- 
2.10.0.372.g6fe1b14
