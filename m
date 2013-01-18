From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 18 Jan 2013 17:42:28 +0100
Subject: [PATCH] at91sam9x5 DTS: add SCK USART pins
Message-ID: <1358527348-24617-1-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SCK pins where missing in usarts pinctrl.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 80cd9ad..4c8ed08 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -148,6 +148,11 @@
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
@@ -166,6 +171,11 @@
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
@@ -184,6 +194,11 @@
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
@@ -202,6 +217,11 @@
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
1.7.2.5
