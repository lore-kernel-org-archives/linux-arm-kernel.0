From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 Sep 2014 21:37:57 +0200
Subject: [PATCH] Documentation: arm: add hardware datasheet reference for
 Marvell Armada XP
Message-ID: <1410896277-32476-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some time ago, the "Function Specifications" for the Marvell Armada XP
processor has been released. However, the "Hardware Specifications"
were not released at the same time. They have now been released
publicly, so this commit updates the Marvell documentation file with
the references to this new documentation.

Three documents are available, one for each of the three variants of
Armada XP: 78230, 78260 and 78460.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/arm/Marvell/README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index 4dc66c1..1745379 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -103,6 +103,10 @@ EBU Armada family
     NOTE: not to be confused with the non-SMP 78xx0 SoCs
     Product Brief: http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf
     Functional Spec: http://www.marvell.com/embedded-processors/armada-xp/assets/ARMADA-XP-Functional-SpecDatasheet.pdf
+    Hardware Specs:
+      http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78230_OS.PDF
+      http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78260_OS.PDF
+      http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78460_OS.PDF
 
   Core: Sheeva ARMv7 compatible
 
-- 
2.0.0
