From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 20 May 2015 20:16:50 +0200
Subject: [PATCH 1/5] ARM: shmobile: bockw-reference dts: Replace "nor-jedec"
 by "jedec, spi-nor"
In-Reply-To: <1432145814-12442-1-git-send-email-geert+renesas@glider.be>
References: <1432145814-12442-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1432145814-12442-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cfr. commit 8947e396a8296c52 ('Documentation: dt: mtd: replace
"nor-jedec" binding with "jedec, spi-nor"')

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index f9422d887b4441c3..dffa6ff303608b19 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -119,7 +119,7 @@
 	flash: flash at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spansion,s25fl008k", "nor-jedec";
+		compatible = "spansion,s25fl008k", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <104000000>;
 		m25p,fast-read;
-- 
1.9.1
