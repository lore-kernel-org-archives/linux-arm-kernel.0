From: chris.paterson2@renesas.com (Chris Paterson)
Date: Wed, 12 Jul 2017 11:03:23 +0100
Subject: [PATCH 1/3] dt-bindings: mmc: sh_mmcif: Document r8a7743 DT bindings
In-Reply-To: <1499853805-5915-1-git-send-email-chris.paterson2@renesas.com>
References: <1499853805-5915-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1499853805-5915-2-git-send-email-chris.paterson2@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
index c32dc5a..703e18c 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
+++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
@@ -11,6 +11,7 @@ Required properties:
 	- "renesas,mmcif-r7s72100" for the MMCIF found in r7s72100 SoCs
 	- "renesas,mmcif-r8a73a4" for the MMCIF found in r8a73a4 SoCs
 	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
+	- "renesas,mmcif-r8a7743" for the MMCIF found in r8a7743 SoCs
 	- "renesas,mmcif-r8a7778" for the MMCIF found in r8a7778 SoCs
 	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
 	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
@@ -21,7 +22,7 @@ Required properties:
 - interrupts: Some SoCs have only 1 shared interrupt, while others have either
   2 or 3 individual interrupts (error, int, card detect). Below is the number
   of interrupts for each SoC:
-    1: r8a73a4, r8a7778, r8a7790, r8a7791, r8a7793, r8a7794
+    1: r8a73a4, r8a7743, r8a7778, r8a7790, r8a7791, r8a7793, r8a7794
     2: r8a7740, sh73a0
     3: r7s72100
 
-- 
1.9.1
