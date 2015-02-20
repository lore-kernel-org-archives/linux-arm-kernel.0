From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 20 Feb 2015 18:04:34 +0100
Subject: [PATCHv2 15/15] Documentation: arm: update supported Marvell EBU
 processors
In-Reply-To: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1424451874-25375-16-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we support Armada 39x, let's add this family of SoC to the
Marvell documentation, and a reference to a link with more details
about those processors. Unfortunately, no datasheet is publicly
available at this time.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/arm/Marvell/README | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index 1745379..18a775d 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -96,6 +96,11 @@ EBU Armada family
 	88F6820
 	88F6828
 
+  Armada 390/398 Flavors:
+	88F6920
+	88F6928
+    Product infos: http://www.marvell.com/embedded-processors/armada-39x/
+
   Armada XP Flavors:
         MV78230
         MV78260
-- 
2.1.0
