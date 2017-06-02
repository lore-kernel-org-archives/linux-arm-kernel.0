From: leilk.liu@mediatek.com (Leilk Liu)
Date: Fri, 2 Jun 2017 15:18:41 +0800
Subject: [PATCH 1/3] dt-bindings: spi: mediatek: Add bindings for mediatek
 MT7622 soc platform
In-Reply-To: <1496387923-31674-1-git-send-email-leilk.liu@mediatek.com>
References: <1496387923-31674-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1496387923-31674-2-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a DT binding documentation for the MT7622 soc.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 .../devicetree/bindings/spi/spi-mt65xx.txt         |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index e43f4cf..c0b1f01 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: should be one of the following.
     - mediatek,mt2701-spi: for mt2701 platforms
     - mediatek,mt6589-spi: for mt6589 platforms
+    - mediatek,mt7622-spi: for mt7622 platforms
     - mediatek,mt8135-spi: for mt8135 platforms
     - mediatek,mt8173-spi: for mt8173 platforms
 
-- 
1.7.9.5
