From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 27 Apr 2015 15:55:23 +0200
Subject: [PATCH 1/2] ARM: shmobile: r8a7740 dtsi: Fix SCIFB naming
Message-ID: <1430142924-15777-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The single SCIFB on R-Mobile A1 is called "scifb", not "scifb8".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Cfr. commit 0b3a0ef613538cae ("ARM: shmobile: r8a73a4: fix scifb* naming")
---
 arch/arm/boot/dts/r8a7740.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index f265b6b194e9774d..d84714468cce18df 100644
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
1.9.1
