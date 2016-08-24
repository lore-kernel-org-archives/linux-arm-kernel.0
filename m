From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 23 Aug 2016 18:33:12 -0700
Subject: [PATCH 3/4] arm64: dts: qcom: msm8916: Add tcsr syscon node
In-Reply-To: <1472002393-1875-1-git-send-email-bjorn.andersson@linaro.org>
References: <1472002393-1875-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1472002393-1875-3-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 3f3ef20865cd..6e599b75525a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -611,6 +611,11 @@
 			clock-names = "core";
 		};
 
+		tcsr: syscon at 1937000 {
+			compatible = "qcom,tcsr-msm8916", "syscon";
+			reg = <0x1937000 0x30000>;
+		};
+
 		wcnss at a21b000 {
 			compatible = "qcom,pronto-v2-pil";
 			reg = <0x0a21b000 0x3000>;
-- 
2.5.0
