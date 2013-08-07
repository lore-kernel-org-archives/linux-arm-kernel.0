From: panetta.mike@gmail.com (Michael Panetta)
Date: Tue,  6 Aug 2013 21:32:50 -0400
Subject: [PATCH] ARM: dts: imx6qdl-wandboard: Add support for i2c1.
Message-ID: <1375839171-13713-1-git-send-email-panetta.mike@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for i2c1 to the wandboard common dtsi file.


Signed-off-by: Michael Panetta <panetta.mike@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index b40bbe1..bc494a0 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -51,6 +51,13 @@
 	status = "okay";
 };
 
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_1>;
+	status = "okay";
+};
+
 &i2c2 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
-- 
1.7.11.7
