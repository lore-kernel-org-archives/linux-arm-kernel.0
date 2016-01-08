From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  8 Jan 2016 11:00:11 -0800
Subject: [PATCH] arm64: dts: Rename qcom,gcc node to clock-controller
Message-ID: <1452279611-10283-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the standard name for clock controller nodes instead of a
qcom specific name.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 915321479998..ba8184d0f948 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -134,7 +134,7 @@
 			#interrupt-cells = <2>;
 		};
 
-		gcc: qcom,gcc at 1800000 {
+		gcc: clock-controller at 1800000 {
 			compatible = "qcom,gcc-msm8916";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
