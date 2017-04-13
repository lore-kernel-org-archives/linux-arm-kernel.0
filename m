From: rafalo@cadence.com (Rafal Ozieblo)
Date: Thu, 13 Apr 2017 14:38:06 +0100
Subject: [PATCH 2/4] net: macb: Add tsu_clk to device tree
In-Reply-To: <1492090439-11793-1-git-send-email-rafalo@cadence.com>
References: <1492090439-11793-1-git-send-email-rafalo@cadence.com>
Message-ID: <1492090686-14778-1-git-send-email-rafalo@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rafal Ozieblo <rafalo@cadence.com>
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
