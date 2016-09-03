From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sat,  3 Sep 2016 14:53:46 +0200
Subject: [PATCH v4 2/2] dt-bindings: qcom: Add MDM9615 bindings
In-Reply-To: <20160903125346.18451-1-narmstrong@baylibre.com>
References: <20160903125346.18451-1-narmstrong@baylibre.com>
Message-ID: <20160903125346.18451-3-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/qcom.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
index 3e24518..43abf4e 100644
--- a/Documentation/devicetree/bindings/arm/qcom.txt
+++ b/Documentation/devicetree/bindings/arm/qcom.txt
@@ -22,6 +22,7 @@ The 'SoC' element must be one of the following strings:
 	msm8916
 	msm8974
 	msm8996
+	mdm9615
 
 The 'board' element must be one of the following strings:
 
-- 
2.7.0
