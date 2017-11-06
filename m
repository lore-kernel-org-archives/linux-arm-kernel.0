From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Mon,  6 Nov 2017 12:38:14 +0530
Subject: [PATCH v2 2/4] arm64: dts: qcom: apq8016-sbc: Allow USR4 LED to
 notify kernel panic
In-Reply-To: <cover.1509951550.git.amit.kucheria@linaro.org>
References: <cover.1509951550.git.amit.kucheria@linaro.org>
Message-ID: <0134cfea0d980093d74617dca4ab5021478eb705.1509951550.git.amit.kucheria@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Blink the LED on a kernel panic.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 1d63e6b..e4a6850 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -174,6 +174,7 @@
 				label = "apq8016-sbc:green:user4";
 				gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
 				linux,default-trigger = "none";
+				panic-indicator;
 				default-state = "off";
 			};
 
-- 
2.7.4
