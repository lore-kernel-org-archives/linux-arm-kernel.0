From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 May 2015 09:54:13 +0900
Subject: [PATCH 05/10] ARM: shmobile: bockw dts: Replace "nor-jedec" by "jedec,
 spi-nor"
In-Reply-To: <cover.1432860632.git.horms+renesas@verge.net.au>
References: <cover.1432860632.git.horms+renesas@verge.net.au>
Message-ID: <9cc785702d9f6367fdecf0fba6e425198e0754c8.1432860632.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Cfr. commit 8947e396a8296c52 ('Documentation: dt: mtd: replace
"nor-jedec" binding with "jedec, spi-nor"')

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index dfbb12e4fef4..90543b12d7e2 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -186,7 +186,7 @@
 	flash: flash at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spansion,s25fl008k", "nor-jedec";
+		compatible = "spansion,s25fl008k", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <104000000>;
 		m25p,fast-read;
-- 
2.1.4
