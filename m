From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Fri, 16 Feb 2018 11:35:00 +0530
Subject: [PATCH v4 1/4] dt-bindings: arm: Document kryo385 cpu
In-Reply-To: <20180216060503.22006-1-rnayak@codeaurora.org>
References: <20180216060503.22006-1-rnayak@codeaurora.org>
Message-ID: <20180216060503.22006-2-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the compatible string for the Kryo385 cpus found in qualcomm
SoCs.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index a0009b72e9be..19611ccb61d9 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -184,6 +184,7 @@ described below.
 			    "nvidia,tegra186-denver"
 			    "qcom,krait"
 			    "qcom,kryo"
+			    "qcom,kryo385"
 			    "qcom,scorpion"
 	- enable-method
 		Value type: <stringlist>
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
