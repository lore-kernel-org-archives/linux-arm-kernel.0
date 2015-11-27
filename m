From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:55:49 +0900
Subject: [PATCH 06/15] ARM: shmobile: r8a7794: remove deprecated
 #gpio-range-cells from dtsi
In-Reply-To: <cover.1448586938.git.horms+renesas@verge.net.au>
References: <cover.1448586938.git.horms+renesas@verge.net.au>
Message-ID: <369d4933db6a515b90d153767159918845eb4f5f.1448586938.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Commit a1bc260bb5f5d9 ("gpio: clean up gpio-ranges documentation")
declares the above property deprecated. That was more than 2 years ago.
Remove it, so it doesn't get copied around needlessly.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 57d188c2bf6d..89e914f2a2cf 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -217,7 +217,6 @@
 	pfc: pin-controller at e6060000 {
 		compatible = "renesas,pfc-r8a7794";
 		reg = <0 0xe6060000 0 0x11c>;
-		#gpio-range-cells = <3>;
 	};
 
 	dmac0: dma-controller at e6700000 {
-- 
2.1.4
