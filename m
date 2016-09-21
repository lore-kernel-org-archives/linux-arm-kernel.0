From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Wed, 21 Sep 2016 21:41:34 +0530
Subject: [PATCH 4/4] ARM: dts: am4372: add DMA properties for tscadc
In-Reply-To: <20160921161134.6951-1-mugunthanvnm@ti.com>
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
Message-ID: <20160921161134.6951-5-mugunthanvnm@ti.com>
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
2.10.0.129.g35f6318
