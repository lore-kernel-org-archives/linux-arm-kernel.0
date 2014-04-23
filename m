From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:26:01 +0900
Subject: [PATCH 33/33] ARM: shmobile: armadillo-reference dts: Seiko
 Instruments, Inc is "sii"
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <dd485ab9a88267f4db0d58ace23b19e876ebf8ac.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Use "sii,s35390a" instead of "seiko,s35390a", cfr.
Documentation/devicetree/bindings/i2c/trivial-devices.txt and
Documentation/devicetree/bindings/vendor-prefixes.txt.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 0cb235a..10344e6 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -180,7 +180,7 @@
 &i2c2 {
 	status = "okay";
 	rtc at 30 {
-		compatible = "seiko,s35390a";
+		compatible = "sii,s35390a";
 		reg = <0x30>;
 	};
 };
-- 
1.8.5.2
