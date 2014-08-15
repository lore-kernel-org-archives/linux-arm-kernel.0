From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 15 Aug 2014 19:42:42 +0200
Subject: [PATCH 14/15] arm: dts: dra7: add DMA properties for UART
In-Reply-To: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1408124563-31541-15-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: devicetree at vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/boot/dts/dra7.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 10066f4..a904561 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -259,6 +259,8 @@
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 			status = "disabled";
+			dmas = <&sdma 49>, <&sdma 50>;
+			dma-names = "tx", "rx";
 		};
 
 		uart2: serial at 4806c000 {
@@ -268,6 +270,8 @@
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 			status = "disabled";
+			dmas = <&sdma 51>, <&sdma 52>;
+			dma-names = "tx", "rx";
 		};
 
 		uart3: serial at 48020000 {
@@ -277,6 +281,8 @@
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 			status = "disabled";
+			dmas = <&sdma 53>, <&sdma 54>;
+			dma-names = "tx", "rx";
 		};
 
 		uart4: serial at 4806e000 {
@@ -286,6 +292,8 @@
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
                         status = "disabled";
+			dmas = <&sdma 55>, <&sdma 56>;
+			dma-names = "tx", "rx";
 		};
 
 		uart5: serial at 48066000 {
@@ -295,6 +303,8 @@
 			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
 			status = "disabled";
+			dmas = <&sdma 63>, <&sdma 64>;
+			dma-names = "tx", "rx";
 		};
 
 		uart6: serial at 48068000 {
@@ -304,6 +314,8 @@
 			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
 			status = "disabled";
+			dmas = <&sdma 79>, <&sdma 80>;
+			dma-names = "tx", "rx";
 		};
 
 		uart7: serial at 48420000 {
-- 
2.0.1
