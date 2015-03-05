From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:03 +0900
Subject: [PATCH 11/13] PM / Domains: R-Mobile SYSC: Document R-Mobile APE6
 (r8a73a4) binding
In-Reply-To: <cover.1425517246.git.horms+renesas@verge.net.au>
References: <cover.1425517246.git.horms+renesas@verge.net.au>
Message-ID: <12920b02c0e438f2b8f636c26755a0361f9966f0.1425517246.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

R-Mobile APE6 (r8a73a4) is handled fine by the same driver and bindings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
index cc3b1f0..beda7d2 100644
--- a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
+++ b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
@@ -11,6 +11,7 @@ Required properties:
 - compatible: Should be "renesas,sysc-<soctype>", "renesas,sysc-rmobile" as
 	      fallback.
 	      Examples with soctypes are:
+		- "renesas,sysc-r8a73a4" (R-Mobile APE6)
 		- "renesas,sysc-r8a7740" (R-Mobile A1)
 		- "renesas,sysc-sh73a0" (SH-Mobile AG5)
 - reg: Two address start and address range blocks for the device:
-- 
2.1.4
