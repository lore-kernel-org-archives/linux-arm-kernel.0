From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu,  7 Jun 2018 10:41:04 +0200
Subject: [PATCH 1/4] dt-bindings: arm: remove PMC bindings
In-Reply-To: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
References: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
Message-ID: <20180607084107.4461-2-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMC bindings are fully described in
Documentation/devicetree/bindings/clock/at91-clock.txt. Remove the
duplicate and incomplete documentation.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/arm/atmel-pmc.txt          | 14 --------------
 1 file changed, 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/atmel-pmc.txt

diff --git a/Documentation/devicetree/bindings/arm/atmel-pmc.txt b/Documentation/devicetree/bindings/arm/atmel-pmc.txt
deleted file mode 100644
index 795cc78543fe..000000000000
--- a/Documentation/devicetree/bindings/arm/atmel-pmc.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-* Power Management Controller (PMC)
-
-Required properties:
-- compatible: Should be "atmel,<chip>-pmc".
-	<chip> can be: at91rm9200, at91sam9260, at91sam9g45, at91sam9n12,
-	at91sam9x5, sama5d3
-
-- reg: Should contain PMC registers location and length
-
-Examples:
-	pmc: pmc at fffffc00 {
-		compatible = "atmel,at91rm9200-pmc";
-		reg = <0xfffffc00 0x100>;
-	};
-- 
2.17.1
