From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 17:39:54 +0200
Subject: [PATCH v2 7/7] mtd: nand: sunxi: update DT bindings
In-Reply-To: <1459352394-22810-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459352394-22810-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459352394-22810-8-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document dmas and dma-names properties.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/sunxi-nand.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/sunxi-nand.txt b/Documentation/devicetree/bindings/mtd/sunxi-nand.txt
index 086d6f4..6fdf8f6 100644
--- a/Documentation/devicetree/bindings/mtd/sunxi-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/sunxi-nand.txt
@@ -11,6 +11,10 @@ Required properties:
     * "ahb" : AHB gating clock
     * "mod" : nand controller clock
 
+Optional properties:
+- dmas : shall reference DMA channel associated to the NAND controller.
+- dma-names : shall be "rxtx".
+
 Optional children nodes:
 Children nodes represent the available nand chips.
 
-- 
2.5.0
