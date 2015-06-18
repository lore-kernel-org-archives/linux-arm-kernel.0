From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Jun 2015 16:27:22 +0200
Subject: [PATCH v2 3/4] net/macb: bindings doc: add sama5d2 compatibility sting
In-Reply-To: <cover.1434637286.git.nicolas.ferre@atmel.com>
References: <cover.1434637286.git.nicolas.ferre@atmel.com>
Message-ID: <4af1b48e32c28127885713d7b0690d5be39e9496.1434637286.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sama5d2 to the biding documentation for this use of the GEM IP.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 Documentation/devicetree/bindings/net/macb.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
index 97349e3f3ff2..b5d79761ac97 100644
--- a/Documentation/devicetree/bindings/net/macb.txt
+++ b/Documentation/devicetree/bindings/net/macb.txt
@@ -7,6 +7,7 @@ Required properties:
   Use "cdns,at32ap7000-macb" for other 10/100 usage or use the generic form: "cdns,macb".
   Use "cdns,pc302-gem" for Picochip picoXcell pc302 and later devices based on
   the Cadence GEM, or the generic form: "cdns,gem".
+  Use "atmel,sama5d2-gem" for the GEM IP (10/100) available on Atmel sama5d2 SoCs.
   Use "atmel,sama5d3-gem" for the Gigabit IP available on Atmel sama5d3 SoCs.
   Use "atmel,sama5d4-gem" for the GEM IP (10/100) available on Atmel sama5d4 SoCs.
   Use "cdns,zynqmp-gem" for Zynq Ultrascale+ MPSoC.
-- 
2.1.3
