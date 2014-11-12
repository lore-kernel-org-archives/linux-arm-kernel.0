From: ibanezchen@gmail.com (Howard Chen)
Date: Thu, 13 Nov 2014 00:07:37 +0800
Subject: [PATCH v6 4/4] DTS: serial: Add bindings documention for the Mediatek
 UARTs
In-Reply-To: <1415808457-4030-1-git-send-email-ibanezchen@gmail.com>
References: <1415808457-4030-1-git-send-email-ibanezchen@gmail.com>
Message-ID: <1415808457-4030-4-git-send-email-ibanezchen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add s devicetree document for Mediatek UART.

Signed-off-by: Howard Chen <ibanezchen@gmail.com>
---
 Documentation/devicetree/bindings/serial/mtk-uart.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
index 48358a3..e2864b7 100644
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -2,9 +2,10 @@
 
 Required properties:
 - compatible should contain:
+  * "mediatek,mt6592-uart" for MT6592 compatible UARTS
   * "mediatek,mt6589-uart" for MT6589 compatible UARTS
   * "mediatek,mt6582-uart" for MT6582 compatible UARTS
-  * "mediatek,mt6577-uart" for all compatible UARTS (MT6589, MT6582, MT6577)
+  * "mediatek,mt6577-uart" for all compatible UARTS on MT65xx
 
 - reg: The base address of the UART register bank.
 
-- 
1.9.1
