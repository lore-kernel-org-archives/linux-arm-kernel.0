From: andy.gross@linaro.org (Andy Gross)
Date: Sun, 12 Jun 2016 01:23:24 -0500
Subject: [PATCH] arm: dts: qcom: Update smem state cells usage
Message-ID: <1465712604-13748-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the qcom,state-cells to qcom,smem-state-cells to
match recent changes to the binding.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index df96ccd..e4437e4 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -177,7 +177,7 @@
 
 		apps_smsm: apps at 0 {
 			reg = <0>;
-			#qcom,state-cells = <1>;
+			#qcom,smem-state-cells = <1>;
 		};
 
 		modem_smsm: modem at 1 {
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 6f16426..3a79d3c 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -182,7 +182,7 @@
 
 		modem_smp2p_out: master-kernel {
 			qcom,entry-name = "master-kernel";
-			#qcom,state-cells = <1>;
+			#qcom,smem-state-cells = <1>;
 		};
 
 		modem_smp2p_in: slave-kernel {
@@ -208,7 +208,7 @@
 		wcnss_smp2p_out: master-kernel {
 			qcom,entry-name = "master-kernel";
 
-			#qcom,state-cells = <1>;
+			#qcom,smem-state-cells = <1>;
 		};
 
 		wcnss_smp2p_in: slave-kernel {
@@ -232,7 +232,7 @@
 		apps_smsm: apps at 0 {
 			reg = <0>;
 
-			#qcom,state-cells = <1>;
+			#qcom,smem-state-cells = <1>;
 		};
 
 		modem_smsm: modem at 1 {
-- 
1.9.1
