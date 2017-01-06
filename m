From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 6 Jan 2017 14:59:46 +0800
Subject: [PATCH 2/3] doc: binding: add new compatible for SDRAM/DDR Controller
In-Reply-To: <20170106065947.30631-1-wenyou.yang@atmel.com>
References: <20170106065947.30631-1-wenyou.yang@atmel.com>
Message-ID: <20170106065947.30631-3-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new compatible "atmel,sama5d4-ddramc" for the SDRAM/DDR
Controller.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 Documentation/devicetree/bindings/arm/atmel-at91.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index 29737b9b616e..9b5de6397666 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -111,6 +111,7 @@ RAMC SDRAM/DDR Controller required properties:
 			"atmel,at91sam9260-sdramc",
 			"atmel,at91sam9g45-ddramc",
 			"atmel,sama5d3-ddramc",
+			"atmel,sama5d4-ddramc",
 - reg: Should contain registers location and length
 
 Examples:
-- 
2.11.0
