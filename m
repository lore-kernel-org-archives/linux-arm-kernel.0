From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 12 Jan 2016 13:46:32 +0000
Subject: [PATCH 1/5] arm64: dts: apq8016-sbc: add regulators support
In-Reply-To: <1452606358-24569-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1452606358-24569-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1452606392-24614-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 141 ++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index db17c5d..f6cd323 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -30,6 +30,147 @@
 		stdout-path = "serial0";
 	};
 
+	smd {
+		rpm {
+			rpm_requests {
+				pm8916-regulators {
+
+					vdd_l1_l2_l3-supply = <&pm8916_s3>;
+					vdd_l5-supply = <&pm8916_s3>;
+					vdd_l4_l5_l6-supply = <&pm8916_s4>;
+					vdd_l7-supply = <&pm8916_s4>;
+
+					s1 {
+						regulator-min-microvolt = <375000>;
+						regulator-max-microvolt = <1562000>;
+
+					};
+
+					s3 {
+						regulator-min-microvolt = <375000>;
+						regulator-max-microvolt = <1562000>;
+
+					};
+
+					s4 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					l1 {
+						regulator-min-microvolt = <375000>;
+						regulator-max-microvolt = <1525000>;
+
+					};
+
+					l2 {
+						regulator-min-microvolt = <375000>;
+						regulator-max-microvolt = <1525000>;
+
+					};
+
+					l3 {
+						regulator-min-microvolt = <375000>;
+						regulator-max-microvolt = <1525000>;
+
+					};
+
+					l4 {
+						regulator-min-microvolt = <1750000>;
+						regulator-max-microvolt = <3337000>;
+
+					};
+
+					l5 {
+						regulator-min-microvolt = <1750000>;
+						regulator-max-microvolt = <3337000>;
+
+					};
+
+					l6 {
+						regulator-min-microvolt = <1750000>;
+						regulator-max-microvolt = <3337000>;
+
+					};
+
+					l7 {
+						regulator-min-microvolt = <1750000>;
+						regulator-max-microvolt = <3337000>;
+
+					};
+
+					l8 {
+						regulator-min-microvolt = <1750000>;
+						regulator-max-microvolt = <3337000>;
+
+					};
+
+					l9 {
+						regulator-min-microvolt = <1750000>;
+						regulator-max-microvolt = <3337000>;
+
+					};
+
+					l10 {
+						regulator-min-microvolt = <1750000>;
+						regulator-max-microvolt = <3337000>;
+
+					};
+
+					l11 {
+						regulator-min-microvolt = <1750000>;
+						regulator-max-microvolt = <3337000>;
+
+					};
+
+					l12 {
+						regulator-min-microvolt = <1750000>;
+						regulator-max-microvolt = <3337000>;
+
+					};
+
+					l13 {
+						regulator-min-microvolt = <1750000>;
+						regulator-max-microvolt = <3337000>;
+
+					};
+
+					l14 {
+						regulator-min-microvolt = <1750000>;
+						regulator-max-microvolt = <3337000>;
+
+					};
+					
+					l15 {
+						regulator-min-microvolt = <1750000>;
+						regulator-max-microvolt = <3337000>;
+					};
+
+					l16 {
+						regulator-min-microvolt = <1750000>;
+						regulator-max-microvolt = <3337000>;
+
+					};
+
+					l17 {
+						regulator-min-microvolt = <1750000>;
+						regulator-max-microvolt = <3337000>;
+
+					};
+
+					l18 {
+						regulator-min-microvolt = <1750000>;
+						regulator-max-microvolt = <3337000>;
+
+					};
+				};
+			};
+		};
+	};
+
 	soc {
 		serial at 78af000 {
 			label = "LS-UART0";
-- 
1.9.1
