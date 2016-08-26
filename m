From: Bhaskar.Upadhaya@nxp.com (Bhaskar Upadhaya)
Date: Fri, 26 Aug 2016 15:57:41 +0530
Subject: [PATCH 02/10] dt-bindings: esdhc: Update bindings for LS1012A
In-Reply-To: <1472207269-18499-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1472207269-18499-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <1472207269-18499-2-git-send-email-Bhaskar.Upadhaya@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
index dedfb02..3257b4a 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
@@ -7,9 +7,9 @@ This file documents differences between the core properties described
 by mmc.txt and the properties used by the sdhci-esdhc driver.
 
 Required properties:
+  - compatible : "fsl,mpc8378-esdhc", "fsl,ls1012a-esdhc0", "fsl,ls1012a-esdhc1".
   - interrupt-parent : interrupt source phandle.
   - clock-frequency : specifies eSDHC base clock frequency.
-
 Optional properties:
   - sdhci,wp-inverted : specifies that eSDHC controller reports
     inverted write-protect state; New devices should use the generic
-- 
1.9.1
