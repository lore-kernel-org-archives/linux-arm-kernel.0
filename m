From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 21 Dec 2016 03:49:37 -0800
Subject: [PATCH 3/5] ARM: dts: qcom: apq8064-sony-yuga: Enable riva-pil
In-Reply-To: <20161221114939.19973-1-bjorn.andersson@linaro.org>
References: <20161221114939.19973-1-bjorn.andersson@linaro.org>
Message-ID: <20161221114939.19973-3-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
index ebd675ca94b4..a34ba3555454 100644
--- a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
@@ -390,5 +390,12 @@
 				pinctrl-0 = <&sdcc3_pins>, <&sdcc3_cd_pin_a>;
 			};
 		};
+
+		riva-pil at 3204000 {
+			status = "okay";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&riva_wlan_pin_a>, <&riva_bt_pin_a>, <&riva_fm_pin_a>;
+		};
 	};
 };
-- 
2.11.0
