From: scott.shu@mediatek.com (Scott Shu)
Date: Tue, 4 Aug 2015 21:54:18 +0800
Subject: [PATCH v3 2/8] dt-bindings: soc: Add SCPSYS compatible support for
 mt6580
In-Reply-To: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
References: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1438696464-59858-3-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds "mediatek,mt6580-scpsys" in the compatible properties of
SCPSYS node for MT6580 SoC.

Signed-off-by: Scott Shu <scott.shu@mediatek.com>
---
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index c051114..7998bc2 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -12,7 +12,7 @@ power/power_domain.txt. It provides the power domains defined in
 include/dt-bindings/power/mt8173-power.h.
 
 Required properties:
-- compatible: Must be "mediatek,mt8173-scpsys"
+- compatible: Must be "mediatek,mt6580-scpsys" or "mediatek,mt8173-scpsys"
 - #power-domain-cells: Must be 1
 - reg: Address range of the SCPSYS unit
 - infracfg: must contain a phandle to the infracfg controller
-- 
1.7.9.5
