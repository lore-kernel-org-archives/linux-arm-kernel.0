From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 13 Dec 2012 10:05:07 +0800
Subject: [PATCH] ASoC: atmel-ssc: change disable to disable in dts node
Message-ID: <1355364307-31584-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the value of status to disabled to keep the consistent

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |    2 +-
 arch/arm/boot/dts/at91sam9263.dtsi |    4 ++--
 arch/arm/boot/dts/at91sam9g45.dtsi |    4 ++--
 arch/arm/boot/dts/at91sam9x5.dtsi  |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index aaa42d8..03c56cb 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -217,7 +217,7 @@
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfffbc000 0x4000>;
 				interrupts = <14 4 5>;
-				status = "disable";
+				status = "disabled";
 			};
 
 			adc0: adc at fffe0000 {
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 3b721ee..15f12dd 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -179,14 +179,14 @@
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfff98000 0x4000>;
 				interrupts = <16 4 5>;
-				status = "disable";
+				status = "disabled";
 			};
 
 			ssc1: ssc at fff9c000 {
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfff9c000 0x4000>;
 				interrupts = <17 4 5>;
-				status = "disable";
+				status = "disabled";
 			};
 
 			macb0: ethernet at fffbc000 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index acfa207..44a38d0 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -232,14 +232,14 @@
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xfff9c000 0x4000>;
 				interrupts = <16 4 5>;
-				status = "disable";
+				status = "disabled";
 			};
 
 			ssc1: ssc at fffa0000 {
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xfffa0000 0x4000>;
 				interrupts = <17 4 5>;
-				status = "disable";
+				status = "disabled";
 			};
 
 			adc0: adc at fffb0000 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 69667d0..0beff72 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -92,7 +92,7 @@
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xf0010000 0x4000>;
 				interrupts = <28 4 5>;
-				status = "disable";
+				status = "disabled";
 			};
 
 			tcb0: timer at f8008000 {
-- 
1.7.9.5
