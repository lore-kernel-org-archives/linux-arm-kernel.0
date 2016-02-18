From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 Feb 2016 17:20:27 +0100
Subject: [PATCH v2 3/6] Documentation: arm: add link to Armada 38x Functional
 Spec
In-Reply-To: <1455812430-4656-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455812430-4656-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1455812430-4656-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 38x Functional Spec is now available (after registration
unfortunately), so add a link to it.

While at it, fix a typo in the reference to the Armada 38x product
page.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/arm/Marvell/README | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index a78453b..fe867f1 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -97,7 +97,8 @@ EBU Armada family
 	88F6810	Armada 380
 	88F6820 Armada 385
 	88F6828 Armada 388
-    Produce infos: http://www.marvell.com/embedded-processors/armada-38x/
+    Product infos:   http://www.marvell.com/embedded-processors/armada-38x/
+    Functional Spec: https://marvellcorp.wufoo.com/forms/marvell-armada-38x-functional-specifications/
     Core: ARM Cortex-A9
 
   Armada 39x Flavors:
-- 
2.6.4
