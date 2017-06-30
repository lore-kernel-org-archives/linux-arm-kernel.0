From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 30 Jun 2017 15:49:00 +0800
Subject: [PATCH] dt-bindings: nvmem: mediatek: add support for MediaTek MT7623
 and MT7622 SoC
Message-ID: <fc06fbe496ac237b961b73d51bb823e4ac2f8578.1498808678.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This updates dt-binding documentation for MediaTek MT7622 and
MT7623 SoC. For the both SoCs supported all rely on the fallback
binding of the generic case with "mediatek,efuse".

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
---
 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
index 74cf529..0668c45 100644
--- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
+++ b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
@@ -3,7 +3,10 @@
 This binding is intended to represent MTK-EFUSE which is found in most Mediatek SOCs.
 
 Required properties:
-- compatible: should be "mediatek,mt8173-efuse" or "mediatek,efuse"
+- compatible: should be
+	      "mediatek,mt7622-efuse", "mediatek,efuse": for MT7622
+	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
+	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
 - reg: Should contain registers location and length
 
 = Data cells =
-- 
2.7.4
