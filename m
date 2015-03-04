From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 12:19:25 +0100
Subject: [PATCH] ARM: at91/dt: sama5d4 xplained: add i2c0
In-Reply-To: <1425437508-30976-2-git-send-email-josh.wu@atmel.com>
References: <1425437508-30976-2-git-send-email-josh.wu@atmel.com>
Message-ID: <1425467965-26461-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i2c0 aka twi0 on sama5d4 xplained board.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index f95ba32e29a5..93e6e1f0c729 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -88,6 +88,10 @@
 				};
 			};
 
+			i2c0: i2c at f8014000 {
+				status = "okay";
+			};
+
 			macb0: ethernet at f8020000 {
 				phy-mode = "rmii";
 				status = "okay";
-- 
2.1.3
