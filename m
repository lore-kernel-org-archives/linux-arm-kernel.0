From: rafalo@cadence.com (Rafal Ozieblo)
Date: Thu, 29 Jun 2017 07:13:20 +0100
Subject: [PATCH v4 2/4] net: macb: Add tsu_clk to device tree
In-Reply-To: <1498716526-1372-1-git-send-email-rafalo@cadence.com>
References: <1498716526-1372-1-git-send-email-rafalo@cadence.com>
Message-ID: <1498716800-7014-1-git-send-email-rafalo@cadence.com>
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
