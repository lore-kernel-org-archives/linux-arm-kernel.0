From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 May 2016 15:11:03 +0200
Subject: [PATCH] ARM: at91: Documentation: update the sama5d2 entry
Message-ID: <1463663463-1581-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the Atmel SoC entry for SAMA5D2 with all the product variants. Add the
datasheet web link, now that it's available, for instant access to full product
documentation.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 Documentation/arm/Atmel/README | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm/Atmel/README b/Documentation/arm/Atmel/README
index 0931cf7e2e56..6ca78f818dbf 100644
--- a/Documentation/arm/Atmel/README
+++ b/Documentation/arm/Atmel/README
@@ -91,9 +91,15 @@ the Atmel website: http://www.atmel.com.
           http://www.atmel.com/Images/Atmel-11238-32-bit-Cortex-A5-Microcontroller-SAMA5D4_Datasheet.pdf
 
       - sama5d2 family
-        - sama5d27
+        - sama5d21
+        - sama5d22
+        - sama5d23
+        - sama5d24
+        - sama5d26
+        - sama5d27 (device superset)
+        - sama5d28 (device superset + environmental monitors)
         + Datasheet
-          Coming soon
+          http://www.atmel.com/Images/Atmel-11267-32-bit-Cortex-A5-Microcontroller-SAMA5D2_Datasheet.pdf
 
 
 Linux kernel information
-- 
2.1.3
