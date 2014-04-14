From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 16:34:11 +0200
Subject: [PATCH v2 1/5] Documentation: dt-bindings: reformat and order list of
 ahci-platform compatibles
In-Reply-To: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397486055-16303-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ahci-platform.txt Device Tree binding documentation is gaining a
growing number of compatible strings, and it will gain one more with
the addition of the Marvell Armada 380 AHCI support. It is therefore
time to reformat this list into a proper bullet list, and more
importantly order it alphabetically;

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 48b285f..5598862 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -4,10 +4,14 @@ SATA nodes are defined to describe on-chip Serial ATA controllers.
 Each SATA controller should have its own node.
 
 Required properties:
-- compatible        : compatible list, one of "snps,spear-ahci",
-                      "snps,exynos5440-ahci", "ibm,476gtr-ahci",
-                      "allwinner,sun4i-a10-ahci", "fsl,imx53-ahci"
-                      "fsl,imx6q-ahci" or "snps,dwc-ahci"
+- compatible        : compatible string, one of:
+  - "allwinner,sun4i-a10-ahci"
+  - "fsl,imx53-ahci"
+  - "fsl,imx6q-ahci"
+  - "ibm,476gtr-ahci"
+  - "snps,dwc-ahci"
+  - "snps,exynos5440-ahci"
+  - "snps,spear-ahci"
 - interrupts        : <interrupt mapping for SATA IRQ>
 - reg               : <registers mapping>
 
-- 
1.8.3.2
