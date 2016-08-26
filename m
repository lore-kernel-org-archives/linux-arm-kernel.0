From: Bhaskar.Upadhaya@nxp.com (Bhaskar Upadhaya)
Date: Fri, 26 Aug 2016 15:57:45 +0530
Subject: [PATCH 06/10] dt-bindings: dspi: Update bindings for LS1012A
In-Reply-To: <1472207269-18499-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1472207269-18499-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <1472207269-18499-6-git-send-email-Bhaskar.Upadhaya@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
---
 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index ff5893d..dad6409 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -2,6 +2,7 @@ ARM Freescale DSPI controller
 
 Required properties:
 - compatible : "fsl,vf610-dspi", "fsl,ls1021a-v1.0-dspi",
+		"fsl,ls1012a-dspi", "fsl,ls1043a-dspi",
 		"fsl,ls2085a-dspi"
 		or
 		"fsl,ls2080a-dspi" followed by "fsl,ls2085a-dspi"
-- 
1.9.1
