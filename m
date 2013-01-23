From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 23 Jan 2013 10:48:56 +0100
Subject: [PATCH 9/9] ARM: at91/dts: correct comment in at91sam9x5.dtsi for mii
In-Reply-To: <cover.1358934163.git.nicolas.ferre@atmel.com>
References: <cover.1358934163.git.nicolas.ferre@atmel.com>
Message-ID: <8461c2f6fdd3ef0b26f931d561435df8cae2a9a5.1358934163.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Douglas Gilbert <dgilbert@interlog.com>

Concerning pinctrl_macb0_rmii_mii, values were okay, but not comments.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index cb711a5..8ecca69 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -260,14 +260,14 @@
 
 					pinctrl_macb0_rmii_mii: macb0_rmii_mii-0 {
 						atmel,pins =
-							<1 8 0x1 0x0	/* PA8 periph A */
-							 1 11 0x1 0x0	/* PA11 periph A */
-							 1 12 0x1 0x0	/* PA12 periph A */
-							 1 13 0x1 0x0	/* PA13 periph A */
-							 1 14 0x1 0x0	/* PA14 periph A */
-							 1 15 0x1 0x0	/* PA15 periph A */
-							 1 16 0x1 0x0	/* PA16 periph A */
-							 1 17 0x1 0x0>;	/* PA17 periph A */
+							<1 8 0x1 0x0	/* PB8 periph A */
+							 1 11 0x1 0x0	/* PB11 periph A */
+							 1 12 0x1 0x0	/* PB12 periph A */
+							 1 13 0x1 0x0	/* PB13 periph A */
+							 1 14 0x1 0x0	/* PB14 periph A */
+							 1 15 0x1 0x0	/* PB15 periph A */
+							 1 16 0x1 0x0	/* PB16 periph A */
+							 1 17 0x1 0x0>;	/* PB17 periph A */
 					};
 				};
 
-- 
1.8.0
