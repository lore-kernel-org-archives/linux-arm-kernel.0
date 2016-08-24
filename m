From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 23 Aug 2016 18:33:10 -0700
Subject: [PATCH 1/4] arm64: dts: qcom: msm8916: Fixup smp2p nodes
Message-ID: <1472002393-1875-1-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The correct property is #qcom,smem-state-cells = <1>;

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 8b10a918b826..4a268e714db5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -738,7 +738,7 @@
 		hexagon_smp2p_out: master-kernel {
 			qcom,entry-name = "master-kernel";
 
-			#qcom,state-cells = <1>;
+			#qcom,smem-state-cells = <1>;
 		};
 
 		hexagon_smp2p_in: slave-kernel {
@@ -763,7 +763,7 @@
 		wcnss_smp2p_out: master-kernel {
 			qcom,entry-name = "master-kernel";
 
-			#qcom,state-cells = <1>;
+			#qcom,smem-state-cells = <1>;
 		};
 
 		wcnss_smp2p_in: slave-kernel {
@@ -786,7 +786,7 @@
 		apps_smsm: apps at 0 {
 			reg = <0>;
 
-			#qcom,state-cells = <1>;
+			#qcom,smem-state-cells = <1>;
 		};
 
 		hexagon_smsm: hexagon at 1 {
-- 
2.5.0
