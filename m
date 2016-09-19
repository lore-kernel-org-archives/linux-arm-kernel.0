From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Mon, 19 Sep 2016 19:53:46 +0530
Subject: [PATCH 2/3] arm: dts: imx7-colibri: Use pwm polarity control
In-Reply-To: <20160919142347.11342-1-bhuvanchandra.dv@toradex.com>
References: <20160919142347.11342-1-bhuvanchandra.dv@toradex.com>
Message-ID: <20160919142347.11342-3-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure PWM polarity control.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 arch/arm/boot/dts/imx7-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index a9cc657..2af5e3e 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -43,7 +43,7 @@
 / {
 	bl: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 	};
 
 	reg_module_3v3: regulator-module-3v3 {
-- 
2.9.2
