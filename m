From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Aug 2017 10:19:33 +0200
Subject: [PATCH 3/9] arm64: dts: r8a7795: correct whitespace of companion
 property
In-Reply-To: <cover.1502961153.git.horms+renesas@verge.net.au>
References: <cover.1502961153.git.horms+renesas@verge.net.au>
Message-ID: <c3a937bbdd91618ede7a582fe5c0d21d5722c3fa.1502961153.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes: 4dad6dcdae7b ("arm64: dts: renesas: r8a7795: add usb2.0 host ch3 device nodes")
Fixes: 1c422b4c501e ("arm64: dts: renesas: r8a7795: Add usb companion property in EHCI")
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index c9f2b87e7ee3..2938195b9571 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1624,7 +1624,7 @@
 			clocks = <&cpg CPG_MOD 703>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
-			companion= <&ohci0>;
+			companion = <&ohci0>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 703>;
 			status = "disabled";
@@ -1637,7 +1637,7 @@
 			clocks = <&cpg CPG_MOD 702>;
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
-			companion= <&ohci1>;
+			companion = <&ohci1>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 702>;
 			status = "disabled";
@@ -1650,7 +1650,7 @@
 			clocks = <&cpg CPG_MOD 701>;
 			phys = <&usb2_phy2>;
 			phy-names = "usb";
-			companion= <&ohci2>;
+			companion = <&ohci2>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 701>;
 			status = "disabled";
@@ -1663,7 +1663,7 @@
 			clocks = <&cpg CPG_MOD 700>;
 			phys = <&usb2_phy3>;
 			phy-names = "usb";
-			companion= <&ohci3>;
+			companion = <&ohci3>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 700>;
 			status = "disabled";
-- 
2.1.4
