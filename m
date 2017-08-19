From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Sun, 20 Aug 2017 02:03:29 +0800
Subject: [PATCH v2 1/2] dt-bindings: serial: 8250: Add MediaTek BTIF
 controller bindings
In-Reply-To: <cover.1503165144.git.sean.wang@mediatek.com>
References: <cover.1503165144.git.sean.wang@mediatek.com>
Message-ID: <29b52a3b95982f1097766d515aae09c57e11b002.1503165144.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Document the devicetree bindings in 8250.txt for MediaTek BTIF
controller which could be found on MT7622 and MT7623 SoC.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/serial/8250.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index 419ff6c..7528d90 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -14,6 +14,9 @@ Required properties:
 	  tegra132, or tegra210.
 	- "nxp,lpc3220-uart"
 	- "ralink,rt2880-uart"
+	- For MediaTek MT7623, must contain "mediatek,mt7623-btif"
+	- For other MediaTek SoCs , must contain "mediatek,<chip>-btif",
+	  "mediatek,mt7623-btif" where <chip> is mt7622.
 	- "altr,16550-FIFO32"
 	- "altr,16550-FIFO64"
 	- "altr,16550-FIFO128"
-- 
2.7.4
