From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Thu, 14 Sep 2017 17:28:13 +0300
Subject: [PATCH 2/3] ARM: dts: at91: sama5d27_som1_ek: fix typos
In-Reply-To: <1505399294-20041-1-git-send-email-claudiu.beznea@microchip.com>
References: <1505399294-20041-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1505399294-20041-3-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@microchip.com>

Fix typos that prevent proper using of uart2 and uart4 devices.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index f13ef4fbab60..be5cd913f274 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -120,7 +120,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_mikrobus2_uart>;
 				atmel,use-dma-rx;
-				atmel-use-dma-tx;
+				atmel,use-dma-tx;
 				status = "okay";
 			};
 
@@ -178,7 +178,7 @@
 			uart4: serial at fc00c000 {
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
-				pinctrl-name = "default";
+				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_mikrobus1_uart>;
 				status = "okay";
 			};
-- 
2.7.4
