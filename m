From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  3 Sep 2018 12:01:59 +0200
Subject: [PATCH v5 7/9] dt-bindings: ata: update ahci_sunxi bindings
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Message-ID: <20180903100201.23131-8-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch update binding with the new R40 compatible.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 45b451961612..e30fd106df4f 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -10,6 +10,7 @@ PHYs.
 Required properties:
 - compatible        : compatible string, one of:
   - "allwinner,sun4i-a10-ahci"
+  - "allwinner,sun8i-r40-ahci"
   - "brcm,iproc-ahci"
   - "hisilicon,hisi-ahci"
   - "cavium,octeon-7130-ahci"
@@ -44,6 +45,7 @@ Required properties when using sub-nodes:
 - #address-cells    : number of cells to encode an address
 - #size-cells       : number of cells representing the size of an address
 
+For allwinner,sun8i-r40-ahci, the reset propertie must be present.
 
 Sub-nodes required properties:
 - reg		    : the port number
-- 
2.16.4
