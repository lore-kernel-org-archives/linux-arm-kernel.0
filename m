From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:52:52 +0900
Subject: [PATCH 03/19] ARM: dts: r8a7790: use fallback pci compatibility string
In-Reply-To: <cover.1456443769.git.horms+renesas@verge.net.au>
References: <cover.1456443769.git.horms+renesas@verge.net.au>
Message-ID: <2d82c14460575bdf7ea78146d988c10db94d8343.1456443769.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7790 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index db019f2619c7..76ddf5c6cca7 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1499,7 +1499,7 @@
 	};
 
 	pci0: pci at ee090000 {
-		compatible = "renesas,pci-r8a7790";
+		compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
 		device_type = "pci";
 		reg = <0 0xee090000 0 0xc00>,
 		      <0 0xee080000 0 0x1100>;
@@ -1534,7 +1534,7 @@
 	};
 
 	pci1: pci at ee0b0000 {
-		compatible = "renesas,pci-r8a7790";
+		compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
 		device_type = "pci";
 		reg = <0 0xee0b0000 0 0xc00>,
 		      <0 0xee0a0000 0 0x1100>;
@@ -1555,7 +1555,7 @@
 	};
 
 	pci2: pci at ee0d0000 {
-		compatible = "renesas,pci-r8a7790";
+		compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
 		device_type = "pci";
 		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
 		power-domains = <&cpg_clocks>;
-- 
2.7.0.rc3.207.g0ac5344
