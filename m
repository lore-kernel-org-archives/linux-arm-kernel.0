From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 09:33:53 +0900
Subject: [PATCH 5/6] ARM: shmobile: dt: Rename incorrect interrupt related
 binding
In-Reply-To: <cover.1444868660.git.horms+renesas@verge.net.au>
References: <cover.1444868660.git.horms+renesas@verge.net.au>
Message-ID: <e5cf79d9957d958c0c5fd1cbc4eda6c48c563888.1444868660.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

interrupts-names => interrupt-names

Other line changes are re-aligning.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../bindings/memory-controllers/renesas-memory-controllers.txt      | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas-memory-controllers.txt b/Documentation/devicetree/bindings/memory-controllers/renesas-memory-controllers.txt
index c64b7925cd09..9f78e6c82740 100644
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
2.1.4
