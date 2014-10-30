From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Oct 2014 10:50:49 +0900
Subject: [PATCH 2/3] clocksource: sh_tmu: Document r8a7778 binding
In-Reply-To: <cover.1414629281.git.horms+renesas@verge.net.au>
References: <cover.1414629281.git.horms+renesas@verge.net.au>
Message-ID: <f9d6ec6f546a061f5b9eeb53927f1bfac5fb8278.1414629281.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The r8a7778 is very similar to the r8a7779, and already handled by
the current driver in the non-DT case.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/timer/renesas,tmu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
index 4ae7910..cd5f20b 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
@@ -10,6 +10,7 @@ Required Properties:
 
   - compatible: must contain one or more of the following:
     - "renesas,tmu-r8a7740" for the r8a7740 TMU
+    - "renesas,tmu-r8a7778" for the r8a7778 TMU
     - "renesas,tmu-r8a7779" for the r8a7779 TMU
     - "renesas,tmu" for any TMU.
       This is a fallback for the above renesas,tmu-* entries
-- 
2.1.1
