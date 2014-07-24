From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 24 Jul 2014 20:46:33 +0200
Subject: [PATCH 2/2] Documentation: arm: misc updates to Marvell EBU SoC status
In-Reply-To: <1406227593-29749-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406227593-29749-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1406227593-29749-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the merging of mach-kirkwood into mach-mvebu, the removal of
mach-kirkwood, and the progress of the integration of mach-dove into
mach-mvebu, this commit makes a few updates to the Marvell README file
in the kernel documentation.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/arm/Marvell/README | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index 5172934..4dc66c1 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -53,8 +53,8 @@ Kirkwood family
                 Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
   Homepage: http://www.marvell.com/embedded-processors/kirkwood/
   Core: Feroceon ARMv5 compatible
-  Linux kernel mach directory: arch/arm/mach-kirkwood
-  Linux kernel plat directory: arch/arm/plat-orion
+  Linux kernel mach directory: arch/arm/mach-mvebu
+  Linux kernel plat directory: none
 
 Discovery family
 ----------------
@@ -136,7 +136,9 @@ Dove family (application processor)
                 Functional Spec : http://www.marvell.com/application-processors/armada-500/assets/Armada-510-Functional-Spec.pdf
   Homepage: http://www.marvell.com/application-processors/armada-500/
   Core: ARMv7 compatible
-  Directory: arch/arm/mach-dove
+
+  Directory: arch/arm/mach-mvebu (DT enabled platforms)
+             arch/arm/mach-dove (non-DT enabled platforms)
 
 PXA 2xx/3xx/93x/95x family
 --------------------------
@@ -254,10 +256,10 @@ Berlin family (Digital Entertainment)
 Long-term plans
 ---------------
 
- * Unify the mach-dove/, mach-mv78xx0/, mach-orion5x/ and
-   mach-kirkwood/ into the mach-mvebu/ to support all SoCs from the
-   Marvell EBU (Engineering Business Unit) in a single mach-<foo>
-   directory. The plat-orion/ would therefore disappear.
+ * Unify the mach-dove/, mach-mv78xx0/, mach-orion5x/ into the
+   mach-mvebu/ to support all SoCs from the Marvell EBU (Engineering
+   Business Unit) in a single mach-<foo> directory. The plat-orion/
+   would therefore disappear.
 
  * Unify the mach-mmp/ and mach-pxa/ into the same mach-pxa
    directory. The plat-pxa/ would therefore disappear.
-- 
2.0.0
