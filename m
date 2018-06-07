From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu,  7 Jun 2018 10:41:05 +0200
Subject: [PATCH 2/4] dt-bindings: clk: at91: Document all the PMC compatibles
In-Reply-To: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
References: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
Message-ID: <20180607084107.4461-3-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing PMC compatibles to the list of available compatibles.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/clock/at91-clock.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index 51c259a92d02..a1f591969538 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -17,14 +17,13 @@ Required properties:
 	"atmel,at91sam9x5-clk-slow-rc-osc":
 		at91 internal slow RC oscillator
 
-	"atmel,at91rm9200-pmc" or
-	"atmel,at91sam9g45-pmc" or
-	"atmel,at91sam9n12-pmc" or
-	"atmel,at91sam9x5-pmc" or
-	"atmel,sama5d3-pmc":
+	"atmel,<chip>-pmc":
 		at91 PMC (Power Management Controller)
 		All at91 specific clocks (clocks defined below) must be child
 		node of the PMC node.
+		<chip> can be: at91rm9200, at91sam9260, at91sam9261,
+		at91sam9263, at91sam9g45, at91sam9n12, at91sam9rl, at91sam9x5,
+		sama5d2, sama5d3 or sama5d4.
 
 	"atmel,at91sam9x5-clk-slow" (under sckc node)
 	or
-- 
2.17.1
