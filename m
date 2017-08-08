From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  8 Aug 2017 09:39:12 +0200
Subject: [PATCH] arm64: dts: renesas: r8a7795: correct whitespace of companion
 property
Message-ID: <1502177952-27983-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes: 4dad6dcdae7b ("arm64: dts: renesas: r8a7795: add usb2.0 host ch3 device nodes")
Fixes: 1c422b4c501e ("arm64: dts: renesas: r8a7795: Add usb companion property in EHCI")
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

 Based on renesas-devel-20170807-v4.13-rc4

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a87ae76880ab..efe2cb2b9951 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1623,7 +1623,7 @@
 			clocks = <&cpg CPG_MOD 703>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
-			companion= <&ohci0>;
+			companion = <&ohci0>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 703>;
 			status = "disabled";
@@ -1636,7 +1636,7 @@
 			clocks = <&cpg CPG_MOD 702>;
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
-			companion= <&ohci1>;
+			companion = <&ohci1>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 702>;
 			status = "disabled";
@@ -1649,7 +1649,7 @@
 			clocks = <&cpg CPG_MOD 701>;
 			phys = <&usb2_phy2>;
 			phy-names = "usb";
-			companion= <&ohci2>;
+			companion = <&ohci2>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 701>;
 			status = "disabled";
@@ -1662,7 +1662,7 @@
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
