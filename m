From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 10 Feb 2015 14:14:45 +0800
Subject: [PATCH 3/3] ARM: at91: sama5d3/dts: add sama5d3 compatiable string
 for nand
In-Reply-To: <1423548885-27589-1-git-send-email-josh.wu@atmel.com>
References: <1423548885-27589-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1423548885-27589-3-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we introduce a new "atmel,sama5d3-nand" compatible string for
sama5d3, Apply it for sama5d3 chip.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

 arch/arm/boot/dts/sama5d3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index c0c3597..7b6c36f 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1398,7 +1398,7 @@
 		};
 
 		nand0: nand at 60000000 {
-			compatible = "atmel,at91rm9200-nand";
+			compatible = "atmel,sama5d3-nand", "atmel,at91rm9200-nand";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
1.9.1
