From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 23 Mar 2018 21:30:36 +0900
Subject: [PATCH 1/2] dt-bindings: net: ave: add PXs3 support
In-Reply-To: <1521808237-3623-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1521808237-3623-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1521808237-3623-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a compatible string for ethernet controller on UniPhier PXs3 SoC.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt b/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
index 270ea4e..96398cc 100644
--- a/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
+++ b/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
@@ -9,6 +9,7 @@ Required properties:
 	- "socionext,uniphier-pxs2-ave4" : for PXs2 SoC
 	- "socionext,uniphier-ld11-ave4" : for LD11 SoC
 	- "socionext,uniphier-ld20-ave4" : for LD20 SoC
+	- "socionext,uniphier-pxs3-ave4" : for PXs3 SoC
  - reg: Address where registers are mapped and size of region.
  - interrupts: Should contain the MAC interrupt.
  - phy-mode: See ethernet.txt in the same directory. Allow to choose
-- 
2.7.4
