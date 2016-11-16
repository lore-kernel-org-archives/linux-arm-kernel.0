From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Tue, 15 Nov 2016 17:19:23 -0800
Subject: [PATCH v3 1/3] dt-bindings: firmware: scm: Add MSM8996 DT bindings
In-Reply-To: <1479259165-1601-1-git-send-email-spjoshi@codeaurora.org>
References: <1479259165-1601-1-git-send-email-spjoshi@codeaurora.org>
Message-ID: <1479259165-1601-2-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SCM DT bindings for Qualcomm's MSM8996 platform.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index 3b4436e..20f26fb 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -10,8 +10,10 @@ Required properties:
  * "qcom,scm-apq8064" for APQ8064 platforms
  * "qcom,scm-msm8660" for MSM8660 platforms
  * "qcom,scm-msm8690" for MSM8690 platforms
+ * "qcom,scm-msm8996" for MSM8996 platforms
  * "qcom,scm" for later processors (MSM8916, APQ8084, MSM8974, etc)
 - clocks: One to three clocks may be required based on compatible.
+ * No clock required for "qcom,scm-msm8996"
  * Only core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660", and "qcom,scm-msm8960"
  * Core, iface, and bus clocks required for "qcom,scm"
 - clock-names: Must contain "core" for the core clock, "iface" for the interface
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
