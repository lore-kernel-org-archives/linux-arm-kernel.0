From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 28 Jan 2016 17:43:47 +0000
Subject: [PATCH v2 4/9] arm64: dts: remove s2 regulator from smd regulators.
In-Reply-To: <1454002960-3106-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454002960-3106-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1454003027-3288-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s2 is spmi controller regulator on msm8916 according to downstream 3.10
kernel, so remove it from the dt to avoid confusion an use of it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9153214..405ea67 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -519,7 +519,6 @@
 					compatible = "qcom,rpm-pm8916-regulators";
 
 					pm8916_s1: s1 {};
-					pm8916_s2: s2 {};
 					pm8916_s3: s3 {};
 					pm8916_s4: s4 {};
 
-- 
1.9.1
