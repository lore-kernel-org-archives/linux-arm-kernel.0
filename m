From: harninder.rai@nxp.com (Harninder Rai)
Date: Wed, 9 Nov 2016 23:34:39 +0530
Subject: [PATCH 2/3] Documentation: DT: add LS1012A compatible for SCFG and
 DCFG
Message-ID: <1478714679-12724-1-git-send-email-harninder.rai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Harninder Rai <harninder.rai@nxp.com>
Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 3b01338..c9c567a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -108,7 +108,7 @@ status.
   - compatible: Should contain a chip-specific compatible string,
 	Chip-specific strings are of the form "fsl,<chip>-scfg",
 	The following <chip>s are known to be supported:
-	ls1021a, ls1043a, ls1046a, ls2080a.
+	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
 
   - reg: should contain base address and length of SCFG memory-mapped registers
 
@@ -126,7 +126,7 @@ core start address and release the secondary core from holdoff and startup.
   - compatible: Should contain a chip-specific compatible string,
 	Chip-specific strings are of the form "fsl,<chip>-dcfg",
 	The following <chip>s are known to be supported:
-	ls1021a, ls1043a, ls1046a, ls2080a.
+	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
 
   - reg : should contain base address and length of DCFG memory-mapped registers
 
-- 
2.7.4
