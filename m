From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 10 Nov 2014 10:32:23 +0900
Subject: [PATCH 6/8] ARM: shmobile: kzm9g-reference dts: Drop bogus 0x
 unit-address prefix
In-Reply-To: <cover.1415582842.git.horms+renesas@verge.net.au>
References: <cover.1415582842.git.horms+renesas@verge.net.au>
Message-ID: <76ddbdc3010fbb6d5974545a9e91a8ac7460a243.1415582842.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 0dac0e6..8c913d9 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -251,7 +251,7 @@
 		};
 	};
 
-	ak4648: ak4648 at 0x12 {
+	ak4648: ak4648 at 12 {
 		#sound-dai-cells = <0>;
 		compatible = "asahi-kasei,ak4648";
 		reg = <0x12>;
-- 
2.1.1
