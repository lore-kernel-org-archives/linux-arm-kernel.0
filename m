From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 2 Dec 2013 17:10:04 +0100
Subject: [PATCH] ARM: at91: add uart aliases to sama5d3 dtsi
Message-ID: <1386000604-20829-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d3_uart.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3_uart.dtsi b/arch/arm/boot/dts/sama5d3_uart.dtsi
index 49d4d76ca6f4..a9fa75e41652 100644
--- a/arch/arm/boot/dts/sama5d3_uart.dtsi
+++ b/arch/arm/boot/dts/sama5d3_uart.dtsi
@@ -12,6 +12,11 @@
 #include <dt-bindings/clk/at91.h>
 
 / {
+	aliases {
+		serial5 = &uart0;
+		serial6 = &uart1;
+	};
+
 	ahb {
 		apb {
 			pinctrl at fffff200 {
-- 
1.8.2.2
