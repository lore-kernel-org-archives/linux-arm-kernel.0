From: mark.roszko@gmail.com (Marek Roszko)
Date: Sat, 23 Aug 2014 23:12:05 -0400
Subject: [PATCH v2 2/3] ARM: at91/dt: at91: use new pinctrl id for sama5
In-Reply-To: <1408849926-9603-1-git-send-email-mark.roszko@gmail.com>
References: <1408849926-9603-1-git-send-email-mark.roszko@gmail.com>
Message-ID: <1408849926-9603-2-git-send-email-mark.roszko@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches the SAMA5D3 to use the new atmel,sama5d3-pinctrl id that was
added with the drive strength options patch.

Signed-off-by: Marek Roszko <mark.roszko@gmail.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 45013b8..7db0e85 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -428,7 +428,7 @@
 			pinctrl at fffff200 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
+				compatible = "atmel,sama5d3-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
 				ranges = <0xfffff200 0xfffff200 0xa00>;
 				atmel,mux-mask = <
 					/*   A          B          C  */
-- 
1.9.1
