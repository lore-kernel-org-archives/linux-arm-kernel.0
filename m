From: nm@ti.com (Nishanth Menon)
Date: Thu, 5 Jun 2014 22:36:00 -0500
Subject: [RFC PATCH 6/7] ARM: dts: OMAP5: add PRM interrupt
In-Reply-To: <1402025761-16831-1-git-send-email-nm@ti.com>
References: <1402025761-16831-1-git-send-email-nm@ti.com>
Message-ID: <1402025761-16831-7-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide OMAP5 interrupt number for PRM

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 3bfda16..ccced95 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -132,6 +132,7 @@
 		prm: prm at 4ae06000 {
 			compatible = "ti,omap5-prm";
 			reg = <0x4ae06000 0x3000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 
 			prm_clocks: clocks {
 				#address-cells = <1>;
-- 
1.7.9.5
