From: josh.wu@atmel.com (Josh Wu)
Date: Fri, 14 Sep 2012 17:01:29 +0800
Subject: [PATCH] ARM: at91/tc: fix typo in the DT document
Message-ID: <1347613289-29072-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 .../devicetree/bindings/arm/atmel-at91.txt         |    2 +-
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
1.7.9.5
