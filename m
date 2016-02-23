From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 23 Feb 2016 14:04:35 +0800
Subject: [PATCH v2 1/2] ARM: at91: sama5d3/dts: add compatiable string for nand
In-Reply-To: <1456207477-7946-1-git-send-email-wenyou.yang@atmel.com>
References: <1456207477-7946-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1456207477-7946-2-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josh Wu <josh.wu@atmel.com>

As introducing a new "atmel,sama5d3-nand" compatible string for
SAMA5D3's nand node, apply it for SAMA5D3 SoC.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v2: None

 arch/arm/boot/dts/sama5d3.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index a532791..ee1b1a8 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1459,7 +1459,7 @@
 		};
 
 		nand0: nand at 60000000 {
-			compatible = "atmel,at91rm9200-nand";
+			compatible = "atmel,sama5d3-nand", "atmel,at91rm9200-nand";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
1.7.9.5
