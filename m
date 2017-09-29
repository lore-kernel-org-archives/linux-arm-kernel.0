From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:14 +0200
Subject: [PATCH 05/22] arm64: dts: renesas: r8a7795: Drop bogus HDMI node
 names suffixes
In-Reply-To: <cover.1506678250.git.horms+renesas@verge.net.au>
References: <cover.1506678250.git.horms+renesas@verge.net.au>
Message-ID: <6b5ac2f1cb1162679662f3be891978d32b345b6f.1506678250.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Node names should not use numerical suffixes if the nodes can be
distinguished by unit-address.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 2938195b9571..5d5174d8635d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2014,7 +2014,7 @@
 			renesas,fcp = <&fcpf1>;
 		};
 
-		hdmi0: hdmi0 at fead0000 {
+		hdmi0: hdmi at fead0000 {
 			compatible = "renesas,r8a7795-hdmi", "renesas,rcar-gen3-hdmi";
 			reg = <0 0xfead0000 0 0x10000>;
 			interrupts = <GIC_SPI 389 IRQ_TYPE_LEVEL_HIGH>;
@@ -2039,7 +2039,7 @@
 			};
 		};
 
-		hdmi1: hdmi1 at feae0000 {
+		hdmi1: hdmi at feae0000 {
 			compatible = "renesas,r8a7795-hdmi", "renesas,rcar-gen3-hdmi";
 			reg = <0 0xfeae0000 0 0x10000>;
 			interrupts = <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4
