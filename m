From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 Aug 2016 13:30:50 +0200
Subject: [PATCH v3 2/2] dt-bindings: qcom: Add MDM9615 bindings
In-Reply-To: <1471951850-29842-1-git-send-email-narmstrong@baylibre.com>
References: <1471951850-29842-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471951850-29842-3-git-send-email-narmstrong@baylibre.com>
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
1.9.1
