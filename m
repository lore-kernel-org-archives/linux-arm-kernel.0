From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 24 Oct 2012 17:33:50 +0200
Subject: [PATCH 1/8] ARM: at91/tc: fix typo in the DT document
In-Reply-To: <cover.1351092432.git.nicolas.ferre@atmel.com>
References: <cover.1351092432.git.nicolas.ferre@atmel.com>
Message-ID: <bc543c9d3af88b9f09cd5514efc893c6f0fa459b.1351092432.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josh Wu <josh.wu@atmel.com>

Signed-off-by: Josh Wu <josh.wu@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: stable <stable@vger.kernel.org> [v3.4]
---
 Documentation/devicetree/bindings/arm/atmel-at91.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index ecc81e3..d187e9f 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -8,7 +8,7 @@ PIT Timer required properties:
   shared across all System Controller members.
 
 TC/TCLIB Timer required properties:
-- compatible: Should be "atmel,<chip>-pit".
+- compatible: Should be "atmel,<chip>-tcb".
   <chip> can be "at91rm9200" or "at91sam9x5"
 - reg: Should contain registers location and length
 - interrupts: Should contain all interrupts for the TC block
-- 
1.7.11.3
