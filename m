From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 21 Aug 2017 01:17:55 +0800
Subject: [PATCH v3 1/2] dt-bindings: serial: 8250: Add MediaTek BTIF
 controller bindings
In-Reply-To: <cover.1503248851.git.sean.wang@mediatek.com>
References: <cover.1503248851.git.sean.wang@mediatek.com>
Message-ID: <0bce3e724939bcab681f280e5a1f7026266e4fb5.1503248851.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Document the devicetree bindings in 8250.txt for MediaTek BTIF
controller which could be found on MT7622 and MT7623 SoC.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/serial/8250.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index 419ff6c..dad3b2e 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -14,6 +14,8 @@ Required properties:
 	  tegra132, or tegra210.
 	- "nxp,lpc3220-uart"
 	- "ralink,rt2880-uart"
+	- For MediaTek BTIF, must contain '"mediatek,<chip>-btif",
+	  "mediatek,mtk-btif"' where <chip> is mt7622, mt7623.
 	- "altr,16550-FIFO32"
 	- "altr,16550-FIFO64"
 	- "altr,16550-FIFO128"
-- 
2.7.4
