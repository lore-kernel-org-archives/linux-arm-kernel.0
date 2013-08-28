From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 28 Aug 2013 13:05:32 +0200
Subject: [PATCH 4/9] ARM: at91/dt: add atmel,
 pullup-gpio to at91rm9200ek usb1 definition
In-Reply-To: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
References: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1377687933-10723-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91rm9200ek.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
index 76f3e87..f2d6d79 100644
--- a/arch/arm/boot/dts/at91rm9200ek.dts
+++ b/arch/arm/boot/dts/at91rm9200ek.dts
@@ -68,6 +68,7 @@
 
 			usb1: gadget at fffb0000 {
 				atmel,vbus-gpio = <&pioD 4 GPIO_ACTIVE_HIGH>;
+				atmel,pullup-gpio = <&pioD 5 GPIO_ACTIVE_HIGH>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usb1_vbus
 					     &pinctrl_usb1_pullup>;
-- 
1.7.9.5
