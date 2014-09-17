From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Wed, 17 Sep 2014 13:53:16 +0530
Subject: [PATCH 1/2] ARM: dts: vf610-colibri: Add ADC support
In-Reply-To: <cover.1410873422.git.maitysanchayan@gmail.com>
References: <cover.1410873422.git.maitysanchayan@gmail.com>
Message-ID: <1015e874d5b13795e38069402a66b4798d79b632.1410873422.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ADC support for Colibri VF61 modules

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vf610-colibri.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi b/arch/arm/boot/dts/vf610-colibri.dtsi
index 0cd8343..275ebec 100644
--- a/arch/arm/boot/dts/vf610-colibri.dtsi
+++ b/arch/arm/boot/dts/vf610-colibri.dtsi
@@ -69,6 +69,16 @@
 	status = "okay";
 };
 
+&adc0 {
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&adc1 {
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &iomuxc {
 	vf610-colibri {
 		pinctrl_esdhc1: esdhc1grp {
-- 
1.7.9.5
