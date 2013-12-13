From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Fri, 13 Dec 2013 16:57:06 +0800
Subject: [PATCHv7 3/4] ARM: dts: Enables FTM PWM device for Vybrid VF610 TOWER
 board.
In-Reply-To: <1386925027-16288-1-git-send-email-Li.Xiubo@freescale.com>
References: <1386925027-16288-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1386925027-16288-4-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/vf610-twr.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 82d352f..3130f85 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -83,6 +83,12 @@
 	status = "okay";
 };
 
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_1>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_1>;
-- 
1.8.4
