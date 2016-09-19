From: marex@denx.de (Marek Vasut)
Date: Mon, 19 Sep 2016 23:38:00 +0200
Subject: [PATCH] of: Add vendor prefix for Aries Embedded GmbH
Message-ID: <20160919213800.9498-1-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add vendor prefix for Aries Embedded GmbH
http://www.aries-embedded.de/

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 69caf14..522dd65 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -27,6 +27,7 @@ analogix	Analogix Semiconductor, Inc.
 apm	Applied Micro Circuits Corporation (APM)
 aptina	Aptina Imaging
 arasan	Arasan Chip Systems
+aries	Aries Embedded GmbH
 arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
 arrow	Arrow Electronics
-- 
2.9.3
