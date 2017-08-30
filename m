From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 30 Aug 2017 12:03:17 +0200
Subject: [PATCH] arm64: dts: r8a7795: Drop bogus HDMI node names suffixes
Message-ID: <1504087397-6211-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Node names should not use numerical suffixes if the nodes can be
distinguished by unit-address.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 8b4dbce860001224..e1ced54d11322cb4 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2702,7 +2702,7 @@
 			renesas,fcp = <&fcpf1>;
 		};
 
-		hdmi0: hdmi0 at fead0000 {
+		hdmi0: hdmi at fead0000 {
 			compatible = "renesas,r8a7795-hdmi", "renesas,rcar-gen3-hdmi";
 			reg = <0 0xfead0000 0 0x10000>;
 			interrupts = <GIC_SPI 389 IRQ_TYPE_LEVEL_HIGH>;
@@ -2727,7 +2727,7 @@
 			};
 		};
 
-		hdmi1: hdmi1 at feae0000 {
+		hdmi1: hdmi at feae0000 {
 			compatible = "renesas,r8a7795-hdmi", "renesas,rcar-gen3-hdmi";
 			reg = <0 0xfeae0000 0 0x10000>;
 			interrupts = <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.7.4
