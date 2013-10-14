From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 14 Oct 2013 18:46:35 +0200
Subject: [PATCH 1/3] ARM: at91/dt/trivial: use macro for AES irq type
Message-ID: <ba9872c3bb29c9a06f06caa8e0b4528329f07675.1381769174.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index ca956b6..b2aabff 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -350,7 +350,7 @@
 			aes at f8038000 {
 				compatible = "atmel,sam9g46-aes";
 				reg = <0xf8038000 0x100>;
-				interrupts = <43 4 0>;
+				interrupts = <43 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			tdes at f803c000 {
-- 
1.8.2.2
