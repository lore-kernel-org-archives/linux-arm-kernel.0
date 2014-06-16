From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 16 Jun 2014 00:50:33 -0300
Subject: [PATCH 08/10] ARM: sun7i: add DMA properties to UARTs
In-Reply-To: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
References: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1402890635-12342-9-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our UARTs also support DMA transfers, let's enable them for the sake of
testing.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index c054ad3..3a33e62 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -712,6 +712,8 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 16>;
+			dmas = <&dma 0 8>, <&dma 0 8>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -722,6 +724,8 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 17>;
+			dmas = <&dma 0 9>, <&dma 0 9>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -732,6 +736,8 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 18>;
+			dmas = <&dma 0 10>, <&dma 0 10>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -742,6 +748,8 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 19>;
+			dmas = <&dma 0 11>, <&dma 0 11>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -752,6 +760,8 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 20>;
+			dmas = <&dma 0 12>, <&dma 0 12>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -762,6 +772,8 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 21>;
+			dmas = <&dma 0 13>, <&dma 0 13>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -772,6 +784,8 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 22>;
+			dmas = <&dma 0 14>, <&dma 0 14>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -782,6 +796,8 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 23>;
+			dmas = <&dma 0 15>, <&dma 0 15>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
-- 
2.0.0
