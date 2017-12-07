From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Thu,  7 Dec 2017 10:19:37 -0500
Subject: [PATCH v2 05/10] arm64: dts: qcom: apq8016-sbc: sort nodes
 alphabetically
In-Reply-To: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
References: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
Message-ID: <20171207151942.5805-6-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also, it was using whitespaces for indentation on some lines, fix that
while moving it.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index d4b35d81a282..981450f50e10 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -544,14 +544,6 @@
 	};
 };
 
-&wcd_codec {
-        status = "okay";
-        clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
-        clock-names = "mclk";
-	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
-	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
-};
-
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l5-supply = <&pm8916_s3>;
@@ -671,3 +663,11 @@
 		regulator-max-microvolt = <3337000>;
 	};
 };
+
+&wcd_codec {
+	status = "okay";
+	clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
+	clock-names = "mclk";
+	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
+};
-- 
2.15.0
