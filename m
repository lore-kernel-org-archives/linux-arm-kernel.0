From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Mon, 24 Mar 2014 10:22:16 +0800
Subject: [PATCHv2 3/3] ARM: dts: vf610-twr: Enables FTM PWM device.
In-Reply-To: <1395627736-5338-1-git-send-email-Li.Xiubo@freescale.com>
References: <1395627736-5338-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1395627736-5338-4-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Yuan Yao <yao.yuan@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 3fabdb5..c016ec8 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -245,6 +245,12 @@
 	};
 };
 
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0>;
+	status = "okay";
+};
+
 &sai2 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
-- 
1.8.4
