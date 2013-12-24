From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:19:34 +0900
Subject: [PATCH 04/21] ARM: shmobile: r8a7740: Specify PFC interrupts in DT
In-Reply-To: <cover.1387893834.git.horms+renesas@verge.net.au>
References: <cover.1387893834.git.horms+renesas@verge.net.au>
Message-ID: <778de006538d932b96c58dd3a43f9e4ef5060940.1387893834.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 2782f64..8280884 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -155,6 +155,15 @@
 		      <0xe605800c 0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupts-extended =
+			<&irqpin0 0 0>, <&irqpin0 1 0>, <&irqpin0 2 0>, <&irqpin0 3 0>,
+			<&irqpin0 4 0>, <&irqpin0 5 0>, <&irqpin0 6 0>, <&irqpin0 7 0>,
+			<&irqpin1 0 0>, <&irqpin1 1 0>, <&irqpin1 2 0>, <&irqpin1 3 0>,
+			<&irqpin1 4 0>, <&irqpin1 5 0>, <&irqpin1 6 0>, <&irqpin1 7 0>,
+			<&irqpin2 0 0>, <&irqpin2 1 0>, <&irqpin2 2 0>, <&irqpin2 3 0>,
+			<&irqpin2 4 0>, <&irqpin2 5 0>, <&irqpin2 6 0>, <&irqpin2 7 0>,
+			<&irqpin3 0 0>, <&irqpin3 1 0>, <&irqpin3 2 0>, <&irqpin3 3 0>,
+			<&irqpin3 4 0>, <&irqpin3 5 0>, <&irqpin3 6 0>, <&irqpin3 7 0>;
 	};
 
 	tpu: pwm at e6600000 {
-- 
1.8.4
