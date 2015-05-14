From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:33 +0900
Subject: [PATCH 04/31] ARM: shmobile: sh73a0 dtsi: Fix SCIFB naming
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <dfaac7b7e4015ca2e690c7ea4421aec1405de966.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The single SCIFB on SH-Mobile AG5 is called "scifb", not "scifb8".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 45b539ce4d35..cde61b463b6a 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -376,7 +376,7 @@
 		status = "disabled";
 	};
 
-	scifb8: serial at e6c30000 {
+	scifb: serial at e6c30000 {
 		compatible = "renesas,scifb-sh73a0", "renesas,scifb";
 		reg = <0xe6c30000 0x100>;
 		interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4
