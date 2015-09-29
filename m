From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 29 Sep 2015 09:52:18 +0100
Subject: [PATCH] ARM: STi: DT: STiH407: Rename incorrect interrupt related
 binding
Message-ID: <1443516738-3569-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

interrupts-names => interrupt-names

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index 1683deb..7992063 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -53,7 +53,7 @@
 			reg = <0x0961f080 0x4>;
 			reg-names = "irqmux";
 			interrupts = <GIC_SPI 188 IRQ_TYPE_NONE>;
-			interrupts-names = "irqmux";
+			interrupt-names = "irqmux";
 			ranges = <0 0x09610000 0x6000>;
 
 			pio0: gpio at 09610000 {
@@ -264,7 +264,7 @@
 			reg = <0x0920f080 0x4>;
 			reg-names = "irqmux";
 			interrupts = <GIC_SPI 189 IRQ_TYPE_NONE>;
-			interrupts-names = "irqmux";
+			interrupt-names = "irqmux";
 			ranges = <0 0x09200000 0x10000>;
 
 			pio10: pio at 09200000 {
@@ -637,7 +637,7 @@
 			reg = <0x0921f080 0x4>;
 			reg-names = "irqmux";
 			interrupts = <GIC_SPI 190 IRQ_TYPE_NONE>;
-			interrupts-names = "irqmux";
+			interrupt-names = "irqmux";
 			ranges = <0 0x09210000 0x10000>;
 
 			tsin4 {
@@ -670,7 +670,7 @@
 			reg = <0x0922f080 0x4>;
 			reg-names = "irqmux";
 			interrupts = <GIC_SPI 191 IRQ_TYPE_NONE>;
-			interrupts-names = "irqmux";
+			interrupt-names = "irqmux";
 			ranges = <0 0x09220000 0x6000>;
 
 			pio30: gpio at 09220000 {
-- 
1.9.1
