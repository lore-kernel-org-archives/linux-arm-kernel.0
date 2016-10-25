From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 26 Oct 2016 12:52:42 +1300
Subject: [PATCH] ARM: mvebu: Update comment for main PLL frequency
Message-ID: <20161025235242.31764-1-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The actual frequency was updated in commit ae142bd99765 ("ARM: mvebu:
Fix the main PLL frequency on Armada 375, 38x and 39x SoCs") but the
comment was not updated. Update it now.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-375.dtsi | 2 +-
 arch/arm/boot/dts/armada-38x.dtsi | 2 +-
 arch/arm/boot/dts/armada-39x.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index cc952cf8ec30..45fa92f9cf5c 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -65,7 +65,7 @@
 	};
 
 	clocks {
-		/* 2 GHz fixed main PLL */
+		/* 1 GHz fixed main PLL */
 		mainpll: mainpll {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 2d7668848c5a..7450e9fea45d 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -661,7 +661,7 @@
 	};
 
 	clocks {
-		/* 2 GHz fixed main PLL */
+		/* 1 GHz fixed main PLL */
 		mainpll: mainpll {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
index 34cba87f9200..de171baffcf6 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -573,7 +573,7 @@
 	};
 
 	clocks {
-		/* 2 GHz fixed main PLL */
+		/* 1 GHz fixed main PLL */
 		mainpll: mainpll {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-- 
2.10.1
