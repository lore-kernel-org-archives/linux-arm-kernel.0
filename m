From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Fri, 26 Sep 2014 18:07:22 +0530
Subject: [PATCH v3] ARM: dts: vf610-colibri: Add ADC support
Message-ID: <beb70de8c539e52a60db95edebf85abda0ee2634.1411734906.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ADC support for Colibri VF61 modules

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vf610-colibri.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi b/arch/arm/boot/dts/vf610-colibri.dtsi
index 0cd8343..c8bf6e2 100644
--- a/arch/arm/boot/dts/vf610-colibri.dtsi
+++ b/arch/arm/boot/dts/vf610-colibri.dtsi
@@ -27,6 +27,14 @@
 
 };
 
+&adc0 {
+	status = "okay";
+};
+
+&adc1 {
+	status = "okay";
+};
+
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
-- 
1.7.9.5
