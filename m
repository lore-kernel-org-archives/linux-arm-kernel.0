From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 20 May 2015 20:16:53 +0200
Subject: [PATCH 4/5] ARM: shmobile: henninger dts: Replace "nor-jedec" by
 "jedec, spi-nor"
In-Reply-To: <1432145814-12442-1-git-send-email-geert+renesas@glider.be>
References: <1432145814-12442-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1432145814-12442-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cfr. commit 8947e396a8296c52 ('Documentation: dt: mtd: replace
"nor-jedec" binding with "jedec, spi-nor"')

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791-henninger.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-henninger.dts
index bb80122b4113bd8a..655d1804e5e9ceda 100644
--- a/arch/arm/boot/dts/r8a7791-henninger.dts
+++ b/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -226,7 +226,7 @@
 	flash at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spansion,s25fl512s", "nor-jedec";
+		compatible = "spansion,s25fl512s", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <30000000>;
 		spi-tx-bus-width = <4>;
-- 
1.9.1
