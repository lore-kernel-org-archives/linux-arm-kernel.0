From: b35083@freescale.com (Jingchang Lu)
Date: Tue, 18 Jun 2013 10:10:17 +0800
Subject: [PATCH 1/2] ARM: dts: vf610-twr: enable i2c0 device
Message-ID: <1371521418-3003-1-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable i2c0 device on Vybrid VF610 Tower Board

Signed-off-by: Jingchang Lu <b35083@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index b3905f5..1a58678 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -50,6 +50,13 @@
 	status = "okay";
 };
 
+&i2c0 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c0_1>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_1>;
-- 
1.8.0
