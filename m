From: tbm@cyrius.com (Martin Michlmayr)
Date: Thu, 25 Jun 2015 18:41:48 -0400
Subject: ARM: add more Alpine file patterns to MAINTAINERS
Message-ID: <20150625224148.GA11992@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add more Alpine file patterns to MAINTAINERS.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


diff --git a/MAINTAINERS b/MAINTAINERS
index 246d9d8..d409d5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -890,6 +890,9 @@ ARM/Annapurna Labs ALPINE ARCHITECTURE
 M:	Tsahee Zidenberg <tsahee@annapurnalabs.com>
 S:	Maintained
 F:	arch/arm/mach-alpine/
+F:	arch/arm/boot/dts/alpine*
+F:	Documentation/devicetree/bindings/arm/al,alpine.txt
+F:	Documentation/devicetree/bindings/arm/*/al,alpine*
 
 ARM/ATMEL AT91RM9200 AND AT91SAM ARM ARCHITECTURES
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>

-- 
Martin Michlmayr
http://www.cyrius.com/
