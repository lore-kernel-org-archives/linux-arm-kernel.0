From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 3 Oct 2013 15:51:27 -0300
Subject: [PATCH v2 3/3] ARM: dts: imx6qdl-sabresd: Add HDMI support
In-Reply-To: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1380826287-30253-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Put the dt entries in alphabetical order

 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 39eafc2..4df4432 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -111,6 +111,11 @@
 	status = "okay";
 };
 
+&hdmi {
+	ddc = <&i2c2>;
+	status = "okay";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -140,6 +145,13 @@
        };
 };
 
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2_2>;
+	status = "okay";
+};
+
 &i2c3 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
-- 
1.8.1.2
