From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Feb 2014 11:23:39 +0100
Subject: [PATCH v2 10/10] Documentation: arm: update Marvell documentation
 about Armada 375/38x
In-Reply-To: <1392200619-3141-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392200619-3141-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392200619-3141-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit updates the documentation that describes the various
families of SOCs produced by Marvell, together with the corresponding
available technical documents. It adds Armada 375 and Armada 38x, and
adds a link to the product brief for the already supported Armada 370.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/arm/Marvell/README | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index 5a930c1..963ec44 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -83,14 +83,24 @@ EBU Armada family
         88F6710
         88F6707
         88F6W11
+    Product Brief: http://www.marvell.com/embedded-processors/armada-300/assets/Marvell_ARMADA_370_SoC.pdf
+
+  Armada 375 Flavors:
+	88F6720
+    Product Brief: http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA_375_SoC-01_product_brief.pdf
+
+  Armada 380/385 Flavors:
+	88F6810
+	88F6820
+	88F6828
 
   Armada XP Flavors:
         MV78230
         MV78260
         MV78460
     NOTE: not to be confused with the non-SMP 78xx0 SoCs
+    Product Brief: http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf
 
-  Product Brief: http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf
   No public datasheet available.
 
   Core: Sheeva ARMv7 compatible
-- 
1.8.3.2
