From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:36:02 +0900
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: use fallback pcie compatibility
 string
In-Reply-To: <1450406163-23795-1-git-send-email-horms+renesas@verge.net.au>
References: <1450406163-23795-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1450406163-23795-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7790 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7dfd393bfc7e..9555766c98b4 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1567,7 +1567,7 @@
 	};
 
 	pciec: pcie at fe000000 {
-		compatible = "renesas,pcie-r8a7790";
+		compatible = "renesas,pcie-r8a7790", "renesas,pcie-rcar-gen2";
 		reg = <0 0xfe000000 0 0x80000>;
 		#address-cells = <3>;
 		#size-cells = <2>;
-- 
2.1.4
