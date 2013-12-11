From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 11 Dec 2013 04:26:29 +0100
Subject: [PATCH 09/10] ARM: shmobile: sh73a0: Specify PFC interrupts in DT
In-Reply-To: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1386732390-31724-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/sh73a0.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 241c8cd..cb073c3 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -242,5 +242,14 @@
 		      <0xe605801c 0x1c>;
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
 };
-- 
1.8.3.2
