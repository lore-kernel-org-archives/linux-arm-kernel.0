From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  9 Jul 2014 17:06:29 +0200
Subject: [PATCHv3 01/34] Documentation: dt: document all the atmel pmc
 compatibles
In-Reply-To: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404918422-7562-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation for atmel-pmc only list one compatible, add the remaining
compatible strings.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/atmel-pmc.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-pmc.txt b/Documentation/devicetree/bindings/arm/atmel-pmc.txt
index 389bed5056e8..795cc78543fe 100644
--- a/Documentation/devicetree/bindings/arm/atmel-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-pmc.txt
@@ -1,7 +1,10 @@
 * Power Management Controller (PMC)
 
 Required properties:
-- compatible: Should be "atmel,at91rm9200-pmc"
+- compatible: Should be "atmel,<chip>-pmc".
+	<chip> can be: at91rm9200, at91sam9260, at91sam9g45, at91sam9n12,
+	at91sam9x5, sama5d3
+
 - reg: Should contain PMC registers location and length
 
 Examples:
-- 
1.9.1
