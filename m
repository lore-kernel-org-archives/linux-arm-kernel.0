From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed,  2 Apr 2014 09:11:36 +0200
Subject: [PATCH v2 2/6] ARM: socfpga: dts: add remaining interrupts for pdma
In-Reply-To: <1396422700-3962-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1396422700-3962-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1396422700-3962-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 0c3344f..7867e7f 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -75,7 +75,14 @@
 			pdma: pdma at ffe01000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0xffe01000 0x1000>;
-				interrupts = <0 104 4>;
+				interrupts = <0 104 4>,
+					     <0 105 4>,
+					     <0 106 4>,
+					     <0 107 4>,
+					     <0 108 4>,
+					     <0 109 4>,
+					     <0 110 4>,
+					     <0 111 4>;
 				#dma-cells = <1>;
 				#dma-channels = <8>;
 				#dma-requests = <32>;
-- 
1.9.1
