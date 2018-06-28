From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 28 Jun 2018 10:13:35 +0300
Subject: [PATCH 1/2] ARM: dts: armada388-clearfog: enable spi flash
Message-ID: <2bc87e3e365c460943730ded86c8fcb1ff55a533.1530170016.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SolidRun Armada 388 SOM has the SPI flash populated by default
unless the customer explicitly asks otherwise. Enable support by
default.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi b/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
index 2d1cea131e71..c990d502d9a4 100644
--- a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
+++ b/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
@@ -99,7 +99,6 @@
 		compatible = "w25q32", "jedec,spi-nor";
 		reg = <0>; /* Chip select 0 */
 		spi-max-frequency = <3000000>;
-		status = "disabled";
 	};
 };
 
-- 
2.18.0
