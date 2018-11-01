From: leilk.liu@mediatek.com (Leilk Liu)
Date: Thu, 1 Nov 2018 14:02:18 +0800
Subject: [PATCH 1/2] spi: mediatek: Add bindings for mediatek MT8183 soc
 platform
In-Reply-To: <1541052139-8845-1-git-send-email-leilk.liu@mediatek.com>
References: <1541052139-8845-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1541052139-8845-2-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a DT binding documentation for the MT8183 soc.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 .../devicetree/bindings/spi/spi-mt65xx.txt         |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index 236dcb0..7940940 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -8,6 +8,7 @@ Required properties:
     - mediatek,mt7622-spi: for mt7622 platforms
     - mediatek,mt8135-spi: for mt8135 platforms
     - mediatek,mt8173-spi: for mt8173 platforms
+    - mediatek,mt8183-spi: for mt8183 platforms
 
 - #address-cells: should be 1.
 
-- 
1.7.9.5
