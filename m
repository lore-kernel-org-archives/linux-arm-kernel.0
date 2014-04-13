From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 13 Apr 2014 09:19:09 +0400
Subject: [PATCH 06/10] ARM: dts: imx51-babbage: Use predefined constants for
 keys definition
In-Reply-To: <1397366353-29395-1-git-send-email-shc_work@mail.ru>
References: <1397366353-29395-1-git-send-email-shc_work@mail.ru>
Message-ID: <1397366353-29395-6-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-babbage.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index a1105dc..57daa06 100644
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
