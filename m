From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Wed,  1 Nov 2017 13:53:32 -0400
Subject: [PATCH 1/4] arm64: dts: qcom: pm8916: fix wcd_codec indentation
In-Reply-To: <20171101175335.22123-1-damien.riegel@savoirfairelinux.com>
References: <20171101175335.22123-1-damien.riegel@savoirfairelinux.com>
Message-ID: <20171101175335.22123-2-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Indentation did not respect kernel standards, so fix that for the usual
indent with tabs, align with spaces. While at it, remove some empty
lines before and after the closing parenthesis of this block.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 arch/arm64/boot/dts/qcom/pm8916.dtsi | 82 ++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index 53deebf9f515..d19f4cb9a5f3 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -96,47 +96,45 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-                wcd_codec: codec at f000 {
-                       compatible = "qcom,pm8916-wcd-analog-codec";
-	               reg = <0xf000 0x200>;
-	               reg-names = "pmic-codec-core";
-	               clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
-	               clock-names = "mclk";
-	               interrupt-parent = <&spmi_bus>;
-	               interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
-	                            <0x1 0xf0 0x1 IRQ_TYPE_NONE>,
-	                            <0x1 0xf0 0x2 IRQ_TYPE_NONE>,
-	                            <0x1 0xf0 0x3 IRQ_TYPE_NONE>,
-	                            <0x1 0xf0 0x4 IRQ_TYPE_NONE>,
-	                            <0x1 0xf0 0x5 IRQ_TYPE_NONE>,
-	                            <0x1 0xf0 0x6 IRQ_TYPE_NONE>,
-	                            <0x1 0xf0 0x7 IRQ_TYPE_NONE>,
-	                            <0x1 0xf1 0x0 IRQ_TYPE_NONE>,
-	                            <0x1 0xf1 0x1 IRQ_TYPE_NONE>,
-	                            <0x1 0xf1 0x2 IRQ_TYPE_NONE>,
-	                            <0x1 0xf1 0x3 IRQ_TYPE_NONE>,
-	                            <0x1 0xf1 0x4 IRQ_TYPE_NONE>,
-	                            <0x1 0xf1 0x5 IRQ_TYPE_NONE>;
-	               interrupt-names = "cdc_spk_cnp_int",
-	                                 "cdc_spk_clip_int",
-	                                 "cdc_spk_ocp_int",
-	                                 "mbhc_ins_rem_det1",
-	                                 "mbhc_but_rel_det",
-	                                 "mbhc_but_press_det",
-	                                 "mbhc_ins_rem_det",
-	                                 "mbhc_switch_int",
-	                                 "cdc_ear_ocp_int",
-	                                 "cdc_hphr_ocp_int",
-	                                 "cdc_hphl_ocp_det",
-	                                 "cdc_ear_cnp_int",
-	                                 "cdc_hphr_cnp_int",
-	                                 "cdc_hphl_cnp_int";
-	               vdd-cdc-io-supply = <&pm8916_l5>;
-	               vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
-	               vdd-micbias-supply = <&pm8916_l13>;
-	               #sound-dai-cells = <1>;
-
-                };
-
+		wcd_codec: codec at f000 {
+			compatible = "qcom,pm8916-wcd-analog-codec";
+			reg = <0xf000 0x200>;
+			reg-names = "pmic-codec-core";
+			clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
+			clock-names = "mclk";
+			interrupt-parent = <&spmi_bus>;
+			interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
+				     <0x1 0xf0 0x1 IRQ_TYPE_NONE>,
+				     <0x1 0xf0 0x2 IRQ_TYPE_NONE>,
+				     <0x1 0xf0 0x3 IRQ_TYPE_NONE>,
+				     <0x1 0xf0 0x4 IRQ_TYPE_NONE>,
+				     <0x1 0xf0 0x5 IRQ_TYPE_NONE>,
+				     <0x1 0xf0 0x6 IRQ_TYPE_NONE>,
+				     <0x1 0xf0 0x7 IRQ_TYPE_NONE>,
+				     <0x1 0xf1 0x0 IRQ_TYPE_NONE>,
+				     <0x1 0xf1 0x1 IRQ_TYPE_NONE>,
+				     <0x1 0xf1 0x2 IRQ_TYPE_NONE>,
+				     <0x1 0xf1 0x3 IRQ_TYPE_NONE>,
+				     <0x1 0xf1 0x4 IRQ_TYPE_NONE>,
+				     <0x1 0xf1 0x5 IRQ_TYPE_NONE>;
+			interrupt-names = "cdc_spk_cnp_int",
+					  "cdc_spk_clip_int",
+					  "cdc_spk_ocp_int",
+					  "mbhc_ins_rem_det1",
+					  "mbhc_but_rel_det",
+					  "mbhc_but_press_det",
+					  "mbhc_ins_rem_det",
+					  "mbhc_switch_int",
+					  "cdc_ear_ocp_int",
+					  "cdc_hphr_ocp_int",
+					  "cdc_hphl_ocp_det",
+					  "cdc_ear_cnp_int",
+					  "cdc_hphr_cnp_int",
+					  "cdc_hphl_cnp_int";
+			vdd-cdc-io-supply = <&pm8916_l5>;
+			vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
+			vdd-micbias-supply = <&pm8916_l13>;
+			#sound-dai-cells = <1>;
+		};
 	};
 };
-- 
2.15.0
