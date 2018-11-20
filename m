From: leilk.liu@mediatek.com (Leilk Liu)
Date: Tue, 20 Nov 2018 16:41:07 +0800
Subject: [PATCH 1/2] spi: mediatek: Add bindings for mediatek MT7629 soc
 platform
In-Reply-To: <1542703268-17285-1-git-send-email-leilk.liu@mediatek.com>
References: <1542703268-17285-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1542703268-17285-2-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a DT binding documentation for the MT7629 soc.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 .../devicetree/bindings/spi/spi-mt65xx.txt         |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index 7940940..6cc4e87 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -6,6 +6,7 @@ Required properties:
     - mediatek,mt2712-spi: for mt2712 platforms
     - mediatek,mt6589-spi: for mt6589 platforms
     - mediatek,mt7622-spi: for mt7622 platforms
+    - mediatek,mt7629-spi: for mt7629 platforms
     - mediatek,mt8135-spi: for mt8135 platforms
     - mediatek,mt8173-spi: for mt8173 platforms
     - mediatek,mt8183-spi: for mt8183 platforms
-- 
1.7.9.5
