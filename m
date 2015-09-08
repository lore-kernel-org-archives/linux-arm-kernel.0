From: agross@codeaurora.org (Andy Gross)
Date: Tue,  8 Sep 2015 16:35:29 -0500
Subject: [PATCH 09/11] arm: dts: Add support for PMA8084 on APQ8084
In-Reply-To: <1441748131-26490-1-git-send-email-agross@codeaurora.org>
References: <1441748131-26490-1-git-send-email-agross@codeaurora.org>
Message-ID: <1441748131-26490-11-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the PMA8084 regulators found on APQ8084
platforms.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi |   52 +++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index c4303b9..1239202 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -329,6 +329,58 @@
 			rpm_requests {
 				compatible = "qcom,rpm-apq8084";
 				qcom,smd-channels = "rpm_requests";
+
+				pma8084-regulators {
+					compatible = "qcom,rpm-pma8084-regulators";
+
+					pma8084_s1: s1 {};
+					pma8084_s2: s2 {};
+					pma8084_s3: s3 {};
+					pma8084_s4: s4 {};
+					pma8084_s5: s5 {};
+					pma8084_s6: s6 {};
+					pma8084_s7: s7 {};
+					pma8084_s8: s8 {};
+					pma8084_s9: s9 {};
+					pma8084_s10: s10 {};
+					pma8084_s11: s11 {};
+					pma8084_s12: s12 {};
+
+					pma8084_l1: l1 {};
+					pma8084_l2: l2 {};
+					pma8084_l3: l3 {};
+					pma8084_l4: l4 {};
+					pma8084_l5: l5 {};
+					pma8084_l6: l6 {};
+					pma8084_l7: l7 {};
+					pma8084_l8: l8 {};
+					pma8084_l9: l9 {};
+					pma8084_l10: l10 {};
+					pma8084_l11: l11 {};
+					pma8084_l12: l12 {};
+					pma8084_l13: l13 {};
+					pma8084_l14: l14 {};
+					pma8084_l15: l15 {};
+					pma8084_l16: l16 {};
+					pma8084_l17: l17 {};
+					pma8084_l18: l18 {};
+					pma8084_l19: l19 {};
+					pma8084_l20: l20 {};
+					pma8084_l21: l21 {};
+					pma8084_l22: l22 {};
+					pma8084_l23: l23 {};
+					pma8084_l24: l24 {};
+					pma8084_l25: l25 {};
+					pma8084_l26: l26 {};
+					pma8084_l27: l27 {};
+
+					pma8084_lvs1: lvs1 {};
+					pma8084_lvs2: lvs2 {};
+					pma8084_lvs3: lvs3 {};
+					pma8084_lvs4: lvs4 {};
+
+					pma8084_5vs1: 5vs1 {};
+				};
 			};
 		};
 	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
