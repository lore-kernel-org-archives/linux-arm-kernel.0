From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Mar 2013 13:09:02 +0100
Subject: [PATCH 7/7] ARM: i.MX27: Add clocks to GPT devicetree nodes
In-Reply-To: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
References: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1363262942-26702-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx27.dtsip | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsip b/arch/arm/boot/dts/imx27.dtsip
index 3e0585f..3ea1f59 100644
--- a/arch/arm/boot/dts/imx27.dtsip
+++ b/arch/arm/boot/dts/imx27.dtsip
@@ -68,18 +68,24 @@
 				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
 				reg = <0x10003000 0x1000>;
 				interrupts = <26>;
+				clocks = <&clks 46>, <&clks 61>;
+				clock-names = "ipg", "per";
 			};
 
 			gpt2: timer at 10004000 {
 				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
 				reg = <0x10004000 0x1000>;
 				interrupts = <25>;
+				clocks = <&clks 45>, <&clks 61>;
+				clock-names = "ipg", "per";
 			};
 
 			gpt3: timer at 10005000 {
 				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
 				reg = <0x10005000 0x1000>;
 				interrupts = <24>;
+				clocks = <&clks 44>, <&clks 61>;
+				clock-names = "ipg", "per";
 			};
 
 			uart1: serial at 1000a000 {
@@ -210,12 +216,16 @@
 				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
 				reg = <0x10019000 0x1000>;
 				interrupts = <4>;
+				clocks = <&clks 43>, <&clks 61>;
+				clock-names = "ipg", "per";
 			};
 
 			gpt5: timer at 1001a000 {
 				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
 				reg = <0x1001a000 0x1000>;
 				interrupts = <3>;
+				clocks = <&clks 42>, <&clks 61>;
+				clock-names = "ipg", "per";
 			};
 
 			uart5: serial at 1001b000 {
@@ -245,6 +255,8 @@
 				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
 				reg = <0x1001f000 0x1000>;
 				interrupts = <2>;
+				clocks = <&clks 41>, <&clks 61>;
+				clock-names = "ipg", "per";
 			};
 		};
 
-- 
1.8.2.rc2
