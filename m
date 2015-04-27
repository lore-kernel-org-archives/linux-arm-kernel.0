From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 27 Apr 2015 15:55:24 +0200
Subject: [PATCH 2/2] ARM: shmobile: sh73a0 dtsi: Fix SCIFB naming
In-Reply-To: <1430142924-15777-1-git-send-email-geert+renesas@glider.be>
References: <1430142924-15777-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1430142924-15777-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The single SCIFB on SH-Mobile AG5 is called "scifb", not "scifb8".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Cfr. commit 0b3a0ef613538cae ("ARM: shmobile: r8a73a4: fix scifb* naming")
---
 arch/arm/boot/dts/sh73a0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 0bdb1da60487b431..11e17c5f26e2cae2 100644
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
1.9.1
