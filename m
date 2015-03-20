From: agross@codeaurora.org (Andy Gross)
Date: Thu, 19 Mar 2015 22:02:08 -0500
Subject: [PATCH] mfd: devicetree: qcom_rpm: document IPQ8064 resources
Message-ID: <1426820528-12013-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josh Cartwright <joshc@codeaurora.org>

The IPQ8064 SoC has several RPM-controlled resources, an NSS fabric
clock and four regulator resources.  Provide definitions for them.

Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
---
 Documentation/devicetree/bindings/mfd/qcom-rpm.txt |    1 +
 include/dt-bindings/mfd/qcom-rpm.h                 |    6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
index 85e3198..94d9ae8 100644
--- a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
@@ -12,6 +12,7 @@ frequencies.
 		    "qcom,rpm-apq8064"
 		    "qcom,rpm-msm8660"
 		    "qcom,rpm-msm8960"
+		    "qcom,rpm-ipq8064"
 
 - reg:
 	Usage: required
diff --git a/include/dt-bindings/mfd/qcom-rpm.h b/include/dt-bindings/mfd/qcom-rpm.h
index 388a6f3..13a9d4b 100644
--- a/include/dt-bindings/mfd/qcom-rpm.h
+++ b/include/dt-bindings/mfd/qcom-rpm.h
@@ -141,6 +141,12 @@
 #define QCOM_RPM_SYS_FABRIC_MODE		131
 #define QCOM_RPM_USB_OTG_SWITCH			132
 #define QCOM_RPM_VDDMIN_GPIO			133
+#define QCOM_RPM_NSS_FABRIC_0_CLK		134
+#define QCOM_RPM_NSS_FABRIC_1_CLK		135
+#define QCOM_RPM_SMB208_S1a			136
+#define QCOM_RPM_SMB208_S1b			137
+#define QCOM_RPM_SMB208_S2a			138
+#define QCOM_RPM_SMB208_S2b			139
 
 /*
  * Constants used to select force mode for regulators.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
