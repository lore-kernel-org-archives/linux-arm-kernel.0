From: shh.xie@gmail.com (shh.xie at gmail.com)
Date: Tue, 13 Sep 2016 16:09:58 +0800
Subject: [PATCH 05/10][v3] dt-bindings: ahci-fsl-qoriq: updated for SoC ls1046a
In-Reply-To: <1473754203-22970-1-git-send-email-shh.xie@gmail.com>
References: <1473754203-22970-1-git-send-email-shh.xie@gmail.com>
Message-ID: <1473754203-22970-6-git-send-email-shh.xie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shaohui Xie <Shaohui.Xie@nxp.com>

Signed-off-by: Shaohui Xie <Shaohui.Xie@nxp.com>
---
change in V3:
1. new patch.

 Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
index 032a760..fc33ca0 100644
--- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
@@ -3,7 +3,7 @@ Binding for Freescale QorIQ AHCI SATA Controller
 Required properties:
   - reg: Physical base address and size of the controller's register area.
   - compatible: Compatibility string. Must be 'fsl,<chip>-ahci', where
-    chip could be ls1021a, ls2080a, ls1043a etc.
+    chip could be ls1021a, ls1043a, ls1046a, ls2080a etc.
   - clocks: Input clock specifier. Refer to common clock bindings.
   - interrupts: Interrupt specifier. Refer to interrupt binding.
 
-- 
2.1.0.27.g96db324
