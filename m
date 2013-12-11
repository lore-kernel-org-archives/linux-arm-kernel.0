From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 11 Dec 2013 04:26:28 +0100
Subject: [PATCH 08/10] ARM: shmobile: r8a7740: Specify PFC interrupts in DT
In-Reply-To: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1386732390-31724-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
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
1.8.3.2
