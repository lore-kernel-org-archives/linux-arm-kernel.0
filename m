From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Mon, 12 Mar 2018 13:36:54 +0530
Subject: [PATCH v6 1/3] dt-bindings: arm: Document kryo385 cpu
In-Reply-To: <20180312080656.13247-1-rnayak@codeaurora.org>
References: <20180312080656.13247-1-rnayak@codeaurora.org>
Message-ID: <20180312080656.13247-2-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the compatible string for the Kryo385 cpus found in qualcomm
SoCs.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index f4a777039f03..8b0328ff951d 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -185,6 +185,7 @@ described below.
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
