From: rafalo@cadence.com (Rafal Ozieblo)
Date: Fri, 16 Jun 2017 13:00:39 +0100
Subject: [PATCH v3 2/4] net: macb: Add tsu_clk to device tree
In-Reply-To: <1497614298-14074-1-git-send-email-rafalo@cadence.com>
References: <1497614298-14074-1-git-send-email-rafalo@cadence.com>
Message-ID: <1497614439-20537-1-git-send-email-rafalo@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rafal Ozieblo <rafalo@cadence.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/macb.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
index 1506e94..27966ae 100644
--- a/Documentation/devicetree/bindings/net/macb.txt
+++ b/Documentation/devicetree/bindings/net/macb.txt
@@ -22,6 +22,7 @@ Required properties:
 	Required elements: 'pclk', 'hclk'
 	Optional elements: 'tx_clk'
 	Optional elements: 'rx_clk' applies to cdns,zynqmp-gem
+	Optional elements: 'tsu_clk'
 - clocks: Phandles to input clocks.
 
 Optional properties for PHY child node:
-- 
2.4.5
