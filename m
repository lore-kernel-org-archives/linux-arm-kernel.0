From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 10 Jun 2014 17:24:38 +0200
Subject: [PATCH] Documentation: arm: add URLs to public datasheets for the
 Marvell Armada 370 SoC
In-Reply-To: <1402413878-20224-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1402413878-20224-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1402413878-20224-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell has very recently released a public version of the "Functional
specifications" and "Hardware specifications" datasheets for the
Marvell Armada 370 SoC. This allows contributors and developers not
under NDA with Marvell to get more details about this SoC than what
the current kernel code shows, and hopefully allows to improve the
support for this SoC in the mainline kernel, as well as in other
projects.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/arm/Marvell/README | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index 963ec44..920dfd2 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -83,7 +83,9 @@ EBU Armada family
         88F6710
         88F6707
         88F6W11
-    Product Brief: http://www.marvell.com/embedded-processors/armada-300/assets/Marvell_ARMADA_370_SoC.pdf
+    Product Brief:   http://www.marvell.com/embedded-processors/armada-300/assets/Marvell_ARMADA_370_SoC.pdf
+    Hardware Spec:   http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-datasheet.pdf
+    Functional Spec: http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-FunctionalSpec-datasheet.pdf
 
   Armada 375 Flavors:
 	88F6720
-- 
2.0.0
