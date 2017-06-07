From: andy.tang@nxp.com (Yuantian Tang)
Date: Wed, 7 Jun 2017 14:32:47 +0800
Subject: [PATCH 1/2] dt-bindings: ahci-fsl-qoriq: add ls1088a chip name to the
 list
Message-ID: <1496817168-26567-1-git-send-email-andy.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
index fc33ca0..7c3ca0e 100644
--- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
@@ -3,7 +3,7 @@ Binding for Freescale QorIQ AHCI SATA Controller
 Required properties:
   - reg: Physical base address and size of the controller's register area.
   - compatible: Compatibility string. Must be 'fsl,<chip>-ahci', where
-    chip could be ls1021a, ls1043a, ls1046a, ls2080a etc.
+    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a etc.
   - clocks: Input clock specifier. Refer to common clock bindings.
   - interrupts: Interrupt specifier. Refer to interrupt binding.
 
-- 
2.1.0.27.g96db324
