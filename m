From: silvio.fricke@gmail.com (Silvio F)
Date: Wed, 22 Jan 2014 20:39:27 +0100
Subject: [PATCH 2/2] ARM: dts: imx6: edmqmx6: remove wrong gpio in
 usb_otg_vbus regulator
In-Reply-To: <1390419567-2643-1-git-send-email-silvio.fricke@gmail.com>
References: <1390419567-2643-1-git-send-email-silvio.fricke@gmail.com>
Message-ID: <1390419567-2643-3-git-send-email-silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Silvio F <silvio.fricke@gmail.com>
---
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index 6706d1b..de54e46 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -46,7 +46,6 @@
 			regulator-name = "usb_otg_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio7 12 0>;
 		};
 
 		reg_usb_host1: regulator at 2 {
-- 
1.8.5.2
