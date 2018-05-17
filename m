From: erin.lo@mediatek.com (Erin Lo)
Date: Thu, 17 May 2018 14:22:04 +0800
Subject: [PATCH v3 2/4] dt-bindings: mtk-sysirq: Add compatible for Mediatek
 MT8183
In-Reply-To: <1526538126-51497-1-git-send-email-erin.lo@mediatek.com>
References: <1526538126-51497-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1526538126-51497-3-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds dt-binding documentation of SYSIRQ for Mediatek MT8183 SoC
Platform.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
index 07bf0b9..5ff48a8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
@@ -5,6 +5,7 @@ interrupt.
 
 Required properties:
 - compatible: should be
+	"mediatek,mt8183-sysirq", "mediatek,mt6577-sysirq": for MT8183
 	"mediatek,mt8173-sysirq", "mediatek,mt6577-sysirq": for MT8173
 	"mediatek,mt8135-sysirq", "mediatek,mt6577-sysirq": for MT8135
 	"mediatek,mt8127-sysirq", "mediatek,mt6577-sysirq": for MT8127
-- 
1.9.1
