From: nm@ti.com (Nishanth Menon)
Date: Thu, 5 Jun 2014 22:36:01 -0500
Subject: [RFC PATCH 7/7] ARM: dts: DRA7: add PRM interrupt
In-Reply-To: <1402025761-16831-1-git-send-email-nm@ti.com>
References: <1402025761-16831-1-git-send-email-nm@ti.com>
Message-ID: <1402025761-16831-8-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide default DRA7 crossbar mapped interrupt for prm interrupt

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c29945e..38e8097 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -85,6 +85,7 @@
 		prm: prm at 4ae06000 {
 			compatible = "ti,dra7-prm";
 			reg = <0x4ae06000 0x3000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 
 			prm_clocks: clocks {
 				#address-cells = <1>;
-- 
1.7.9.5
