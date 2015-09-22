From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 22 Sep 2015 10:39:45 -0700
Subject: [PATCH] arm: dts: qcom: Add size element to coincell reg property
Message-ID: <1442943585-32525-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This node is missing a size element that we typically have for
all other PMIC dts nodes. Add it.

Cc: Tim Bird <tim.bird@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-pm8941.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index 5df51a586571..d456e2fc55c9 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -127,7 +127,7 @@
 
 		coincell at 2800 {
 			compatible = "qcom,pm8941-coincell";
-			reg = <0x2800>;
+			reg = <0x2800 0x100>;
 			status = "disabled";
 		};
 	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
