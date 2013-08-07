From: panetta.mike@gmail.com (Michael Panetta)
Date: Tue,  6 Aug 2013 21:32:51 -0400
Subject: [PATCH] ARM: dts: imx6qdl-wandboard: Add support for i2c3.
In-Reply-To: <1375839171-13713-1-git-send-email-panetta.mike@gmail.com>
References: <1375839171-13713-1-git-send-email-panetta.mike@gmail.com>
Message-ID: <1375839171-13713-2-git-send-email-panetta.mike@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for i2c3 to the wandboard common dtsi file.

Signed-off-by: Michael Panetta <panetta.mike@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index bc494a0..cc042ea 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -73,6 +73,13 @@
 	};
 };
 
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3_3>;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
-- 
1.7.11.7
