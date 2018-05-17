From: erin.lo@mediatek.com (Erin Lo)
Date: Thu, 17 May 2018 14:22:05 +0800
Subject: [PATCH v3 3/4] dt-bindings: serial: Add compatible for Mediatek MT8183
In-Reply-To: <1526538126-51497-1-git-send-email-erin.lo@mediatek.com>
References: <1526538126-51497-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1526538126-51497-4-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds dt-binding documentation of uart for Mediatek MT8183 SoC
Platform.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 Documentation/devicetree/bindings/serial/mtk-uart.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
index f73abff..4783336 100644
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -15,6 +15,7 @@ Required properties:
   * "mediatek,mt8127-uart" for MT8127 compatible UARTS
   * "mediatek,mt8135-uart" for MT8135 compatible UARTS
   * "mediatek,mt8173-uart" for MT8173 compatible UARTS
+  * "mediatek,mt8183-uart", "mediatek,mt6577-uart" for MT8183 compatible UARTS
   * "mediatek,mt6577-uart" for MT6577 and all of the above
 
 - reg: The base address of the UART register bank.
-- 
1.9.1
