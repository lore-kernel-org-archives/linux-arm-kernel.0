From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 22 Feb 2014 16:53:39 +0100
Subject: [PATCH v7 10/15] ata: ahci_platform: Update DT compatible list
In-Reply-To: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393084424-31099-11-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roger Quadros <rogerq@ti.com>

The ahci_platform driver supports "snps,dwc-ahci".
Add this to the DT binding information.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index d86e854..48b285f 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -6,8 +6,8 @@ Each SATA controller should have its own node.
 Required properties:
 - compatible        : compatible list, one of "snps,spear-ahci",
                       "snps,exynos5440-ahci", "ibm,476gtr-ahci",
-                      "allwinner,sun4i-a10-ahci", "fsl,imx53-ahci" or
-                      "fsl,imx6q-ahci"
+                      "allwinner,sun4i-a10-ahci", "fsl,imx53-ahci"
+                      "fsl,imx6q-ahci" or "snps,dwc-ahci"
 - interrupts        : <interrupt mapping for SATA IRQ>
 - reg               : <registers mapping>
 
-- 
1.9.0
