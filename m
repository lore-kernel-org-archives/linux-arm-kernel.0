From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Wed, 10 Dec 2014 20:55:02 +0900
Subject: [PATCH] ARM: shmobile: r8a7793: document CPG clock support
Message-ID: <1418212502-19905-1-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
 Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
index e6ad35b..fc7ef99 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
@@ -8,6 +8,7 @@ Required Properties:
   - compatible: Must be one of
     - "renesas,r8a7790-cpg-clocks" for the r8a7790 CPG
     - "renesas,r8a7791-cpg-clocks" for the r8a7791 CPG
+    - "renesas,r8a7793-cpg-clocks" for the r8a7793 CPG
     - "renesas,r8a7794-cpg-clocks" for the r8a7794 CPG
     - "renesas,rcar-gen2-cpg-clocks" for the generic R-Car Gen2 CPG
 
-- 
1.9.1
