From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 20 Apr 2016 17:32:07 +0200
Subject: [PATCH 02/14] ARM: dts: omap5-board-common: DT spelling
 s/interrupt-name/interrupt-names/
In-Reply-To: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1461166339-11109-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index 902657d6713b073d..cdd144acbd3fbb53 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -395,7 +395,7 @@
 			compatible = "ti,palmas-pmic";
 			interrupt-parent = <&palmas>;
 			interrupts = <14 IRQ_TYPE_NONE>;
-			interrupt-name = "short-irq";
+			interrupt-names = "short-irq";
 
 			ti,ldo6-vibrator;
 
-- 
1.9.1
