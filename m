From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Tue, 7 Jan 2014 16:13:58 +0800
Subject: [PATCHv9 3/4] ARM: dts: Enables FTM PWM device for Vybrid VF610 TOWER
 board.
In-Reply-To: <1389082438-2199-1-git-send-email-Li.Xiubo@freescale.com>
References: <1389082438-2199-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1389082438-2199-2-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---


No changes since v7.




 arch/arm/boot/dts/vf610-twr.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index c3a3237..d5c6a39 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -100,6 +100,12 @@
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
