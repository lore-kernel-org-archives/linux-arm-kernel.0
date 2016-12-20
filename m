From: joerg.krause@embedded.rocks (=?UTF-8?q?J=C3=B6rg=20Krause?=)
Date: Tue, 20 Dec 2016 16:35:16 +0100
Subject: [PATCH] ARM: dts: imx28: Add simple-card support
Message-ID: <20161220153516.19222-1-joerg.krause@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple-card support to SAIF0 and SAIF1.

Signed-off-by: J?rg Krause <joerg.krause@embedded.rocks>
---
 arch/arm/boot/dts/imx28.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index afcf687..5783e26 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -1087,6 +1087,7 @@
 			};
 
 			saif0: saif at 80042000 {
+				#sound-dai-cells = <0>;
 				compatible = "fsl,imx28-saif";
 				reg = <0x80042000 0x2000>;
 				interrupts = <59>;
@@ -1104,6 +1105,7 @@
 			};
 
 			saif1: saif at 80046000 {
+				#sound-dai-cells = <0>;
 				compatible = "fsl,imx28-saif";
 				reg = <0x80046000 0x2000>;
 				interrupts = <58>;
-- 
2.10.2
