From: kbeldan@baylibre.com (Karl Beldan)
Date: Wed,  3 Aug 2016 16:25:28 +0000
Subject: [PATCH] ARM: dt: da850: add nand_cs3 node label in the dtsi
Message-ID: <20160803162528.2337-1-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow to adjust the related settings in the board files.

Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 25f0f8e..3a00978 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -375,7 +375,7 @@
 			dma-names = "tx", "rx";
 		};
 	};
-	nand_cs3 at 62000000 {
+	nand_cs3: nand_cs3 at 62000000 {
 		compatible = "ti,davinci-nand";
 		reg = <0x62000000 0x807ff
 		       0x68000000 0x8000>;
-- 
2.9.0.rc1
