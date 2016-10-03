From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Mon, 3 Oct 2016 18:33:17 +0530
Subject: [PATCH v2 3/4] ARM: dts: am33xx: add DMA properties for tscadc
In-Reply-To: <20161003130318.12591-1-mugunthanvnm@ti.com>
References: <20161003130318.12591-1-mugunthanvnm@ti.com>
Message-ID: <20161003130318.12591-4-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DMA properties for tscadc

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 98748c6..6d607b8 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -917,6 +917,8 @@
 			interrupts = <16>;
 			ti,hwmods = "adc_tsc";
 			status = "disabled";
+			dmas = <&edma 53 0>, <&edma 57 0>;
+			dma-names = "fifo0", "fifo1";
 
 			tsc {
 				compatible = "ti,am3359-tsc";
-- 
2.10.0.372.g6fe1b14
