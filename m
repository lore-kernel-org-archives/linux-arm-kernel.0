From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 20 Apr 2016 17:32:08 +0200
Subject: [PATCH 03/14] ARM: dts: omap5-cm-t54: DT spelling
 s/interrupt-name/interrupt-names/
In-Reply-To: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1461166339-11109-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/omap5-cm-t54.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index ecc591dc0778ddbf..467291d71e96e5fe 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -434,7 +434,7 @@
 			compatible = "ti,palmas-pmic";
 			interrupt-parent = <&palmas>;
 			interrupts = <14 IRQ_TYPE_NONE>;
-			interrupt-name = "short-irq";
+			interrupt-names = "short-irq";
 
 			ti,ldo6-vibrator;
 
-- 
1.9.1
