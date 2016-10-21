From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 10:51:12 +0200
Subject: [PATCH v2 1/6] ARM: dts: STiH407: DT fix
 s/interrupts-names/interrupt-names/
In-Reply-To: <1477039877-20227-1-git-send-email-geert+renesas@glider.be>
References: <1477039877-20227-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1477039877-20227-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
---
v2:
  - Add Acked-by.
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index c325cc059ae4bc80..daab16b5ae645cee 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -1157,7 +1157,7 @@
 			reg = <0x0923f080 0x4>;
 			reg-names = "irqmux";
 			interrupts = <GIC_SPI 192 IRQ_TYPE_NONE>;
-			interrupts-names = "irqmux";
+			interrupt-names = "irqmux";
 			ranges = <0 0x09230000 0x3000>;
 
 			pio40: gpio at 09230000 {
-- 
1.9.1
