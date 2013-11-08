From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 8 Nov 2013 16:08:11 +0100
Subject: [PATCH RESEND 2/7] ARM: at91/dt/trivial: before sama5d3,
 Atmel MPU were using at91 prefix
In-Reply-To: <cover.1383922546.git.nicolas.ferre@atmel.com>
References: <cover.1383922546.git.nicolas.ferre@atmel.com>
Message-ID: <0e4b89d9b3f9ece88fa9d55365b6dc372e38896f.1383922546.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the sha/aes/tdes compatibility string to match common
case for the at91sam9g45 family which is to keep the at91 prefix.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index fca56c7..8716fc2 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -351,19 +351,19 @@
 			};
 
 			sha at f8034000 {
-				compatible = "atmel,sam9g46-sha";
+				compatible = "atmel,at91sam9g46-sha";
 				reg = <0xf8034000 0x100>;
 				interrupts = <42 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			aes at f8038000 {
-				compatible = "atmel,sam9g46-aes";
+				compatible = "atmel,at91sam9g46-aes";
 				reg = <0xf8038000 0x100>;
 				interrupts = <43 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			tdes at f803c000 {
-				compatible = "atmel,sam9g46-tdes";
+				compatible = "atmel,at91sam9g46-tdes";
 				reg = <0xf803c000 0x100>;
 				interrupts = <44 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
-- 
1.8.2.2
