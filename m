From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 24 Jul 2014 20:46:32 +0200
Subject: [PATCH 1/2] Documentation: arm: add URLs to public datasheets for the
 Marvell Armada XP SoC
In-Reply-To: <1406227593-29749-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406227593-29749-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1406227593-29749-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell has very recently released a public version of the "Functional
specifications" and "Hardware specifications" datasheets for the
Marvell Armada XP SoC. This allows contributors and developers not
under NDA with Marvell to get more details about this SoC than what
the current kernel code shows, and hopefully allows to improve the
support for this SoC in the mainline kernel, as well as in other
projects.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/arm/Marvell/README | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index 1af3a5d..5172934 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -102,8 +102,7 @@ EBU Armada family
         MV78460
     NOTE: not to be confused with the non-SMP 78xx0 SoCs
     Product Brief: http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf
-
-  No public datasheet available.
+    Functional Spec: http://www.marvell.com/embedded-processors/armada-xp/assets/ARMADA-XP-Functional-SpecDatasheet.pdf
 
   Core: Sheeva ARMv7 compatible
 
-- 
2.0.0
