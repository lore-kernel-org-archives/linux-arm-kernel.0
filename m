From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 29 Sep 2015 09:43:08 +0100
Subject: [PATCH] ARM: shmobile: dt: Rename incorrect interrupt related binding
Message-ID: <1443516188-3308-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

interrupts-names => interrupt-names

Other line changes are re-aligning.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../bindings/memory-controllers/renesas-memory-controllers.txt      | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas-memory-controllers.txt b/Documentation/devicetree/bindings/memory-controllers/renesas-memory-controllers.txt
index c64b792..9f78e6c 100644
--- a/Documentation/devicetree/bindings/memory-controllers/renesas-memory-controllers.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas-memory-controllers.txt
@@ -24,9 +24,9 @@ Required properties:
 Optional properties:
   - interrupts: Must contain a list of interrupt specifiers for memory
 		controller interrupts, if available.
-  - interrupts-names: Must contain a list of interrupt names corresponding to
-		      the interrupts in the interrupts property, if available.
-		      Valid interrupt names are:
+  - interrupt-names: Must contain a list of interrupt names corresponding to
+		     the interrupts in the interrupts property, if available.
+		     Valid interrupt names are:
 			- "sec" (secure interrupt)
 			- "temp" (normal (temperature) interrupt)
   - power-domains: Must contain a reference to the PM domain that the memory
-- 
1.9.1
