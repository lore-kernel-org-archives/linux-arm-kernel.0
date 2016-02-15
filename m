From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Feb 2016 09:47:43 +0100
Subject: [PATCH 3/5] Documentation: arm: improve Marvell EBU Armada
 documentation
In-Reply-To: <1455526065-7307-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455526065-7307-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1455526065-7307-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit improves the Marvell EBU Armada documentation by:

 - Clarifying which core is used by each SoC. Indeed, the Armada 370
   and XP use a Marvell ARMv7 compatible core, while Armada 375, 38x
   and 39x use the ARM Cortex-A9 core.

 - Adding a link to the web form that allows to get the Armada 38x
   Functional Specifications.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/arm/Marvell/README | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index 74f7ce3..57f8293 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -86,20 +86,25 @@ EBU Armada family
     Product Brief:   http://www.marvell.com/embedded-processors/armada-300/assets/Marvell_ARMADA_370_SoC.pdf
     Hardware Spec:   http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-datasheet.pdf
     Functional Spec: http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-FunctionalSpec-datasheet.pdf
+    Core:            Marvell PJ4B, ARMv7 compatible
 
   Armada 375 Flavors:
 	88F6720
     Product Brief: http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA_375_SoC-01_product_brief.pdf
+    Core:          ARM Cortex-A9
 
   Armada 380/385 Flavors:
 	88F6810
 	88F6820
 	88F6828
+    Functional spec: https://marvellcorp.wufoo.com/forms/marvell-armada-38x-functional-specifications/
+    Core:          ARM Cortex-A9
 
   Armada 390/398 Flavors:
 	88F6920
 	88F6928
     Product infos: http://www.marvell.com/embedded-processors/armada-39x/
+    Core:          ARM Cortex-A9
 
   Armada XP Flavors:
         MV78230
@@ -112,8 +117,7 @@ EBU Armada family
       http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78230_OS.PDF
       http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78260_OS.PDF
       http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78460_OS.PDF
-
-  Core: Sheeva ARMv7 compatible
+    Core: Marvell PJ4B-MP, ARMv7 compatible
 
   Linux kernel mach directory: arch/arm/mach-mvebu
   Linux kernel plat directory: none
-- 
2.6.4
