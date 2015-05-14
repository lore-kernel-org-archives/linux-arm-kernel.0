From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:32 +0900
Subject: [PATCH 03/31] ARM: shmobile: r8a7740 dtsi: Fix SCIFB naming
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <50663822618670a1e6ea1dd9912790fd7ed3be0b.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The single SCIFB on R-Mobile A1 is called "scifb", not "scifb8".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 83c1c3ca1b8f..413590d6c316 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -275,7 +275,7 @@
 		status = "disabled";
 	};
 
-	scifb8: serial at e6c30000 {
+	scifb: serial at e6c30000 {
 		compatible = "renesas,scifb-r8a7740", "renesas,scifb";
 		reg = <0xe6c30000 0x100>;
 		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4
