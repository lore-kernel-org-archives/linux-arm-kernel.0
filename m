From: eagle.alexander923@gmail.com (Alexander Shiyan)
Date: Sun, 23 Jun 2013 10:54:47 +0400
Subject: [PATCH 3/6] ARM: dts: imx27: Rename PWM devicetree node
In-Reply-To: <1371970490-10874-1-git-send-email-eagle.alexander923@gmail.com>
References: <1371970490-10874-1-git-send-email-eagle.alexander923@gmail.com>
Message-ID: <1371970490-10874-3-git-send-email-eagle.alexander923@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Shiyan <shc_work@mail.ru>

i.MX27 have only one PWM, so index from PWM devicetree node removed.

Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
---
 arch/arm/boot/dts/imx27.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 5009d93..845af3f 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -102,7 +102,7 @@
 				clock-names = "ipg", "per";
 			};
 
-			pwm0: pwm at 10006000 {
+			pwm: pwm at 10006000 {
 				compatible = "fsl,imx27-pwm";
 				reg = <0x10006000 0x1000>;
 				interrupts = <23>;
-- 
1.8.1.5
