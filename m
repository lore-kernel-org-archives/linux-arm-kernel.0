From: agross@codeaurora.org (Andy Gross)
Date: Wed, 23 Sep 2015 11:53:24 -0500
Subject: [Patch v2 05/10] arm64: dts: Add PM8916 support on MSM8916
In-Reply-To: <1443027209-19444-1-git-send-email-agross@codeaurora.org>
References: <1443027209-19444-1-git-send-email-agross@codeaurora.org>
Message-ID: <1443027209-19444-6-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the PM8916 regulator nodes found on MSM8916 platforms.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 27d3e90..d2b07eb 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -444,6 +444,34 @@
 			rpm_requests {
 				compatible = "qcom,rpm-msm8916";
 				qcom,smd-channels = "rpm_requests";
+
+				pm8916-regulators {
+					compatible = "qcom,rpm-pm8916-regulators";
+
+					pm8916_s1: s1 {};
+					pm8916_s2: s2 {};
+					pm8916_s3: s3 {};
+					pm8916_s4: s4 {};
+
+					pm8916_l1: l1 {};
+					pm8916_l2: l2 {};
+					pm8916_l3: l3 {};
+					pm8916_l4: l4 {};
+					pm8916_l5: l5 {};
+					pm8916_l6: l6 {};
+					pm8916_l7: l7 {};
+					pm8916_l8: l8 {};
+					pm8916_l9: l9 {};
+					pm8916_l10: l10 {};
+					pm8916_l11: l11 {};
+					pm8916_l12: l12 {};
+					pm8916_l13: l13 {};
+					pm8916_l14: l14 {};
+					pm8916_l15: l15 {};
+					pm8916_l16: l16 {};
+					pm8916_l17: l17 {};
+					pm8916_l18: l18 {};
+				};
 			};
 		};
 	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
