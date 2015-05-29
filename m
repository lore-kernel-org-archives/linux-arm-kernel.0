From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 May 2015 09:54:10 +0900
Subject: [PATCH 02/10] ARM: shmobile: koelsch dts: Replace "nor-jedec" by
 "jedec, spi-nor"
In-Reply-To: <cover.1432860632.git.horms+renesas@verge.net.au>
References: <cover.1432860632.git.horms+renesas@verge.net.au>
Message-ID: <cc3db02c9c7cb0c322263b3a6983023b04e3944f.1432860632.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Cfr. commit 8947e396a8296c52 ('Documentation: dt: mtd: replace
"nor-jedec" binding with "jedec, spi-nor"')

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 9cb8a6c8e3f1..f8cd86b9d27f 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -474,7 +474,7 @@
 	flash: flash at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spansion,s25fl512s", "nor-jedec";
+		compatible = "spansion,s25fl512s", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <30000000>;
 		spi-tx-bus-width = <4>;
-- 
2.1.4
