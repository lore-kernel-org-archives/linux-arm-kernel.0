From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Fri, 28 Oct 2016 17:14:23 -0700
Subject: [PATCH 1/1] arm64: dts: msm8996: Add SCM DT node
Message-ID: <1477700063-18641-1-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SCM DT node to enable SCM functionality on MSM8996.

Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 9e960c1..4927097 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -164,6 +164,12 @@
 
 	};
 
+	firmware {
+		scm {
+			compatible = "qcom,scm-msm8996";
+		};
+	};
+
 	tcsr_mutex: hwlock {
 		compatible = "qcom,tcsr-mutex";
 		syscon = <&tcsr_mutex_regs 0 0x1000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
