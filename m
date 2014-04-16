From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 16 Apr 2014 11:24:53 +0400
Subject: [PATCH 4/8] ARM: dts: imx51-babbage: Use predefined constants for
 keys definition
In-Reply-To: <1397633097-1640-1-git-send-email-shc_work@mail.ru>
References: <1397633097-1640-1-git-send-email-shc_work@mail.ru>
Message-ID: <1397633097-1640-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-babbage.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 1652f6a..a8d6168 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -88,7 +88,7 @@
 		power {
 			label = "Power Button";
 			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
-			linux,code = <116>; /* KEY_POWER */
+			linux,code = <KEY_POWER>;
 			gpio-key,wakeup;
 		};
 	};
-- 
1.8.3.2
