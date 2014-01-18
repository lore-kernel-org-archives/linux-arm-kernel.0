From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Jan 2014 17:05:19 -0800
Subject: [PATCH] dt-bindings: qcom: Fix warning with duplicate dt define
Message-ID: <1390007119-4544-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/boot/dts/include/dt-bindings/clock/qcom,mmcc-msm8974.h:60:0:
warning: "RBCPR_CLK_SRC" redefined

Rename this to MMSS_RBCPR_CLK_SRC to avoid conflicts with the
RBCPR clock in the gcc header.

Reported-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 include/dt-bindings/clock/qcom,mmcc-msm8974.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/qcom,mmcc-msm8974.h b/include/dt-bindings/clock/qcom,mmcc-msm8974.h
index 04d318d1187a..032ed87ef0f3 100644
--- a/include/dt-bindings/clock/qcom,mmcc-msm8974.h
+++ b/include/dt-bindings/clock/qcom,mmcc-msm8974.h
@@ -57,7 +57,7 @@
 #define EXTPCLK_CLK_SRC					40
 #define HDMI_CLK_SRC					41
 #define VSYNC_CLK_SRC					42
-#define RBCPR_CLK_SRC					43
+#define MMSS_RBCPR_CLK_SRC				43
 #define CAMSS_CCI_CCI_AHB_CLK				44
 #define CAMSS_CCI_CCI_CLK				45
 #define CAMSS_CSI0_AHB_CLK				46
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
