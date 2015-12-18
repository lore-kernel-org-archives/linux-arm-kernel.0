From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:52 +0900
Subject: [PATCH 22/25] ARM: shmobile: r8a7791: IPMMU compat string SoC part
 number update
In-Reply-To: <cover.1450402264.git.horms+renesas@verge.net.au>
References: <cover.1450402264.git.horms+renesas@verge.net.au>
Message-ID: <3c8ab0c88eff0a5cc61bc56a5929819f26da0b4a.1450402264.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Update IPMMU compat strings to include SoC part number.

By specifying SoC part number in DT it becomes possible
to implement SoC specific features in the IPMMU driver.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 3a2551094b8b..3f15aa7dc4d6 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1590,7 +1590,7 @@
 	};
 
 	ipmmu_sy0: mmu at e6280000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6280000 0 0x1000>;
 		interrupts = <0 223 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 224 IRQ_TYPE_LEVEL_HIGH>;
@@ -1599,7 +1599,7 @@
 	};
 
 	ipmmu_sy1: mmu at e6290000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6290000 0 0x1000>;
 		interrupts = <0 225 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
@@ -1607,7 +1607,7 @@
 	};
 
 	ipmmu_ds: mmu at e6740000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6740000 0 0x1000>;
 		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 199 IRQ_TYPE_LEVEL_HIGH>;
@@ -1616,7 +1616,7 @@
 	};
 
 	ipmmu_mp: mmu at ec680000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xec680000 0 0x1000>;
 		interrupts = <0 226 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
@@ -1624,7 +1624,7 @@
 	};
 
 	ipmmu_mx: mmu at fe951000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xfe951000 0 0x1000>;
 		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 221 IRQ_TYPE_LEVEL_HIGH>;
@@ -1633,7 +1633,7 @@
 	};
 
 	ipmmu_rt: mmu at ffc80000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xffc80000 0 0x1000>;
 		interrupts = <0 307 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
@@ -1641,7 +1641,7 @@
 	};
 
 	ipmmu_gp: mmu at e62a0000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xe62a0000 0 0x1000>;
 		interrupts = <0 260 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 261 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4
