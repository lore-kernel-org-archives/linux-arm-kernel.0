From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 30 Apr 2014 13:15:11 -0500
Subject: [PATCH] clk: qcom: Remove accidental merged reject file
Message-ID: <1398881711-5566-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like commit cff558c79f572530bdbbb9b847134094008afcef accidentally
added in a merge reject file, so remove it.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 Documentation/devicetree/bindings/clock/qcom,gcc.txt.rej | 10 ----------
 1 file changed, 10 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc.txt.rej

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt.rej b/Documentation/devicetree/bindings/clock/qcom,gcc.txt.rej
deleted file mode 100644
index 2e84dbe..0000000
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.txt.rej
+++ /dev/null
@@ -1,10 +0,0 @@
---- Documentation/devicetree/bindings/clock/qcom,gcc.txt
-+++ Documentation/devicetree/bindings/clock/qcom,gcc.txt
-@@ -4,6 +4,7 @@
- Required properties :
- - compatible : shall contain only one of the following:
- 
-+			"qcom,gcc-apq8064"
- 			"qcom,gcc-ipq8064"
- 			"qcom,gcc-msm8660"
- 			"qcom,gcc-msm8960"
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
