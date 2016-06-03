From: andy.gross@linaro.org (Andy Gross)
Date: Fri,  3 Jun 2016 18:25:30 -0500
Subject: [Patch v6 10/10] dts: qcom: apq8064: Add SCM firmware node
In-Reply-To: <1464996330-16952-1-git-send-email-andy.gross@linaro.org>
References: <1464996330-16952-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1464996330-16952-11-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the firmware node for the APQ8064

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index df96ccd..cf37d55 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -213,6 +213,12 @@
 		};
 	};
 
+	firmware {
+		scm {
+			compatible = "qcom,scm-apq8064";
+		};
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1
