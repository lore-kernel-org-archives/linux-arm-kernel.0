From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:52:51 +0900
Subject: [PATCH 02/19] ARM: dts: r8a7791: use fallback pcie compatibility
 string
In-Reply-To: <cover.1456443769.git.horms+renesas@verge.net.au>
References: <cover.1456443769.git.horms+renesas@verge.net.au>
Message-ID: <bbb45f69f7ae68f422a6aafccdc48e3637669c39.1456443769.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7791 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 14aa62539ff2..4456f54a5005 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1600,7 +1600,7 @@
 	};
 
 	pciec: pcie at fe000000 {
-		compatible = "renesas,pcie-r8a7791";
+		compatible = "renesas,pcie-r8a7791", "renesas,pcie-rcar-gen2";
 		reg = <0 0xfe000000 0 0x80000>;
 		#address-cells = <3>;
 		#size-cells = <2>;
-- 
2.7.0.rc3.207.g0ac5344
