From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 22 Jan 2013 18:50:43 +0100
Subject: [PATCH 3/6] ARM: at91/at91sam9x5 DTS: add SCK USART pins
In-Reply-To: <cover.1358876553.git.nicolas.ferre@atmel.com>
References: <cover.1358876553.git.nicolas.ferre@atmel.com>
Message-ID: <8a88c30462a5ec8a35adef88ecd00835c3375273.1358876553.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Genoud <richard.genoud@gmail.com>

The SCK pins where missing in usarts pinctrl.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index e9c4290..cb711a5 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -143,6 +143,11 @@
 						atmel,pins =
 							<0 3 0x1 0x0>;	/* PA3 periph A */
 					};
+
+					pinctrl_usart0_sck: usart0_sck-0 {
+						atmel,pins =
+							<0 4 0x1 0x0>;	/* PA4 periph A */
+					};
 				};
 
 				usart1 {
@@ -161,6 +166,11 @@
 						atmel,pins =
 							<2 28 0x3 0x0>;	/* PC28 periph C */
 					};
+
+					pinctrl_usart1_sck: usart1_sck-0 {
+						atmel,pins =
+							<2 28 0x3 0x0>;	/* PC29 periph C */
+					};
 				};
 
 				usart2 {
@@ -179,6 +189,11 @@
 						atmel,pins =
 							<1 1 0x2 0x0>;	/* PB1 periph B */
 					};
+
+					pinctrl_usart2_sck: usart2_sck-0 {
+						atmel,pins =
+							<1 2 0x2 0x0>;	/* PB2 periph B */
+					};
 				};
 
 				usart3 {
@@ -197,6 +212,11 @@
 						atmel,pins =
 							<2 25 0x2 0x0>;	/* PC25 periph B */
 					};
+
+					pinctrl_usart3_sck: usart3_sck-0 {
+						atmel,pins =
+							<2 26 0x2 0x0>;	/* PC26 periph B */
+					};
 				};
 
 				uart0 {
-- 
1.8.0
