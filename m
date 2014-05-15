From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 May 2014 17:15:24 +0200
Subject: [PATCH 2/2] ARM: at91/dt: add NAND + DMA property for at91sam9rl
In-Reply-To: <47a342121566bca0025a20a57282fb72c990ce09.1400166895.git.nicolas.ferre@atmel.com>
References: <47a342121566bca0025a20a57282fb72c990ce09.1400166895.git.nicolas.ferre@atmel.com>
Message-ID: <e1b405979615b46321a63df3f91f1998763b22fe.1400166895.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the "atmel,nand-has-dma" property to NAND node

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9rl.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 412617084cfd..f21163c7dc2b 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -95,6 +95,7 @@
 			      <0xffffe800 0x200>;
 			atmel,nand-addr-offset = <21>;
 			atmel,nand-cmd-offset = <22>;
+			atmel,nand-has-dma;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
 			gpios = <&pioD 17 GPIO_ACTIVE_HIGH>,
-- 
1.8.2.2
