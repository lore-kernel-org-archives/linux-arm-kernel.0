From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Tue, 10 Oct 2017 13:09:44 +0300
Subject: [PATCH v2 09/14] ARM: dts: at91: sama5d2_xplained: set PB_USER as
 wakeup source
In-Reply-To: <1507630189-15504-1-git-send-email-claudiu.beznea@microchip.com>
References: <1507630189-15504-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1507630189-15504-10-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@microchip.com>

Set the PB_USER button as a wakeup source to resume from ulp0 mode.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
[claudiu.beznea at microchip.com: change subject to match the desired prefix]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index c7e9ccf2bc87..0b78476cec4a 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -522,6 +522,7 @@
 			label = "PB_USER";
 			gpios = <&pioA PIN_PB9 GPIO_ACTIVE_LOW>;
 			linux,code = <0x104>;
+			wakeup-source;
 		};
 	};
 
-- 
2.7.4
