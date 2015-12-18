From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:36:03 +0900
Subject: [PATCH 2/2] ARM: shmobile: r8a7791: use fallback pcie compatibility
 string
In-Reply-To: <1450406163-23795-1-git-send-email-horms+renesas@verge.net.au>
References: <1450406163-23795-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1450406163-23795-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7791 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 2a369ddcb6fd..1d3a13f3f729 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1564,7 +1564,7 @@
 	};
 
 	pciec: pcie at fe000000 {
-		compatible = "renesas,pcie-r8a7791";
+		compatible = "renesas,pcie-r8a7791", "renesas,pcie-rcar-gen2";
 		reg = <0 0xfe000000 0 0x80000>;
 		#address-cells = <3>;
 		#size-cells = <2>;
-- 
2.1.4
