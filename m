From: leilk.liu@mediatek.com (Leilk Liu)
Date: Thu, 31 Dec 2015 10:59:03 +0800
Subject: [PATCH 4/4] Document: spi: Add bindings for mediatek MT2701 soc
 platform
In-Reply-To: <1451530743-8995-1-git-send-email-leilk.liu@mediatek.com>
References: <1451530743-8995-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1451530743-8995-5-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a DT binding documentation for the MT2701 soc.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 .../devicetree/bindings/spi/spi-mt65xx.txt         |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index ce363c923f..bf489e0 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -2,9 +2,10 @@ Binding for MTK SPI controller
 
 Required properties:
 - compatible: should be one of the following.
-    - mediatek,mt8173-spi: for mt8173 platforms
-    - mediatek,mt8135-spi: for mt8135 platforms
+    - mediatek,mt2701-spi: for mt2701 platforms
     - mediatek,mt6589-spi: for mt6589 platforms
+    - mediatek,mt8135-spi: for mt8135 platforms
+    - mediatek,mt8173-spi: for mt8173 platforms
 
 - #address-cells: should be 1.
 
-- 
1.7.9.5
