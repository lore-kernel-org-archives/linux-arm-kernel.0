From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Mon, 12 Mar 2018 19:42:23 +0530
Subject: [PATCH v7 2/3] dt-bindings: qcom: Add SDM845 bindings
In-Reply-To: <20180312141224.11907-1-rnayak@codeaurora.org>
References: <20180312141224.11907-1-rnayak@codeaurora.org>
Message-ID: <20180312141224.11907-3-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a SoC string 'sdm845' for the qualcomm SDM845 SoC

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/qcom.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
index 0ed4d39d7fe1..ee532e705d6c 100644
--- a/Documentation/devicetree/bindings/arm/qcom.txt
+++ b/Documentation/devicetree/bindings/arm/qcom.txt
@@ -26,6 +26,7 @@ The 'SoC' element must be one of the following strings:
 	msm8996
 	mdm9615
 	ipq8074
+	sdm845
 
 The 'board' element must be one of the following strings:
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
