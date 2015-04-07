From: g.portay@overkiz.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Tue,  7 Apr 2015 16:11:23 +0200
Subject: [PATCH 1/2] ARM: at91/dt: sam9x5: add pinctrl for pwm0
In-Reply-To: <1428415884-30662-1-git-send-email-g.portay@overkiz.com>
References: <1428415884-30662-1-git-send-email-g.portay@overkiz.com>
Message-ID: <1428415884-30662-2-git-send-email-g.portay@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Defines the pinctrl configurations for PWM0.

Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index d221179..08ed53d 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -463,6 +463,52 @@
 					};
 				};
 
+				pwm0 {
+					pinctrl_pwm0_pwm0_0: pwm0_pwm0-0 {
+						atmel,pins =
+							<AT91_PIOB 11 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PB11 periph B */
+					};
+					pinctrl_pwm0_pwm0_1: pwm0_pwm0-1 {
+						atmel,pins =
+							<AT91_PIOC 10 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PC10 periph C */
+					};
+					pinctrl_pwm0_pwm0_2: pwm0_pwm0-2 {
+						atmel,pins =
+							<AT91_PIOC 18 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PC18 periph C */
+					};
+
+					pinctrl_pwm0_pwm1_0: pwm0_pwm1-0 {
+						atmel,pins =
+							<AT91_PIOB 12 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PB12 periph B */
+					};
+					pinctrl_pwm0_pwm1_1: pwm0_pwm1-1 {
+						atmel,pins =
+							<AT91_PIOC 11 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PC11 periph C */
+					};
+					pinctrl_pwm0_pwm1_2: pwm0_pwm1-2 {
+						atmel,pins =
+							<AT91_PIOC 19 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PC19 periph C */
+					};
+
+					pinctrl_pwm0_pwm2_0: pwm0_pwm2-0 {
+						atmel,pins =
+							<AT91_PIOB 13 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PB13 periph B */
+					};
+					pinctrl_pwm0_pwm2_1: pwm0_pwm2-1 {
+						atmel,pins =
+							<AT91_PIOC 20 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PC20 periph C */
+					};
+
+					pinctrl_pwm0_pwm3_0: pwm0_pwm3-0 {
+						atmel,pins =
+							<AT91_PIOB 14 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PB14 periph B */
+					};
+					pinctrl_pwm0_pwm3_1: pwm0_pwm3-1 {
+						atmel,pins =
+							<AT91_PIOC 21 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PC21 periph C */
+					};
+				};
+
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
-- 
1.9.1
