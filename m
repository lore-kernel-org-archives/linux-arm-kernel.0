From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Thu,  7 Dec 2017 10:19:34 -0500
Subject: [PATCH v2 02/10] arm64: dts: qcom: msm8916-pins: remove assignments
 to bias-disable
In-Reply-To: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
References: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
Message-ID: <20171207151942.5805-3-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop assignments to bias-disable as the documentation [1] states that
this property doesn't take a value. Other occurrences of this property
respect that.

[1] Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.txt

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Changes in v2:
 - Added Reviewed-by Bjorn Andersson

 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 4cb0b5834143..c67ad8ed8b60 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -278,7 +278,7 @@
 		pinconf {
 			pins = "gpio6", "gpio7";
 			drive-strength = <16>;
-			bias-disable = <0>;
+			bias-disable;
 		};
 	};
 
@@ -290,7 +290,7 @@
 		pinconf {
 			pins = "gpio6", "gpio7";
 			drive-strength = <2>;
-			bias-disable = <0>;
+			bias-disable;
 		};
 	};
 
@@ -302,7 +302,7 @@
 		pinconf {
 			pins = "gpio14", "gpio15";
 			drive-strength = <16>;
-			bias-disable = <0>;
+			bias-disable;
 		};
 	};
 
@@ -314,7 +314,7 @@
 		pinconf {
 			pins = "gpio14", "gpio15";
 			drive-strength = <2>;
-			bias-disable = <0>;
+			bias-disable;
 		};
 	};
 
@@ -326,7 +326,7 @@
 		pinconf {
 			pins = "gpio22", "gpio23";
 			drive-strength = <16>;
-			bias-disable = <0>;
+			bias-disable;
 		};
 	};
 
@@ -338,7 +338,7 @@
 		pinconf {
 			pins = "gpio22", "gpio23";
 			drive-strength = <2>;
-			bias-disable = <0>;
+			bias-disable;
 		};
 	};
 
-- 
2.15.0
