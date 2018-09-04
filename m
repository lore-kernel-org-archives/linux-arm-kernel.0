From: argus.lin@mediatek.com (Argus Lin)
Date: Tue, 4 Sep 2018 20:31:52 +0800
Subject: [PATCH 1/3] dt-bindings: pwrap: mediatek: add pwrap support for MT6765
In-Reply-To: <1536064314-31967-1-git-send-email-argus.lin@mediatek.com>
References: <1536064314-31967-1-git-send-email-argus.lin@mediatek.com>
Message-ID: <1536064314-31967-2-git-send-email-argus.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding document of pwrap for MT6765 SoCs.

Signed-off-by: Argus Lin <argus.lin@mediatek.com>
---
 Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
index f9987c3..359d64f 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
@@ -19,6 +19,7 @@ IP Pairing
 Required properties in pwrap device node.
 - compatible:
 	"mediatek,mt2701-pwrap" for MT2701/7623 SoCs
+	"mediatek,mt6765-pwrap" for MT6765 SoCs
 	"mediatek,mt6797-pwrap" for MT6797 SoCs
 	"mediatek,mt7622-pwrap" for MT7622 SoCs
 	"mediatek,mt8135-pwrap" for MT8135 SoCs
-- 
1.8.1.1.dirty
