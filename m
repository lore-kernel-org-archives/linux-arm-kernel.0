From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 14 Jan 2014 14:34:44 +0800
Subject: [PATCH] ARM: at91: enable USB host on at91sam9n12ek board
Message-ID: <1389681284-28833-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable USB host on at91sam9n12ek board.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/boot/dts/at91sam9n12ek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index e9487f6..924a6a6 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -124,6 +124,10 @@
 			nand-on-flash-bbt;
 			status = "okay";
 		};
+
+		usb0: ohci at 00500000 {
+			status = "okay";
+		};
 	};
 
 	leds {
-- 
1.8.5.2
