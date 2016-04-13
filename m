From: yao.yuan@freescale.com (Yuan Yao)
Date: Wed, 13 Apr 2016 18:08:26 +0800
Subject: [PATCH v2 1/2] Documentation: fsl-quadspi: Add fsl,
 ls1043a-qspi compatible string
In-Reply-To: <1460542107-45807-1-git-send-email-yao.yuan@freescale.com>
References: <1460542107-45807-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <1460542107-45807-2-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao <yao.yuan@nxp.com>

new compatible string: "fsl,ls1043a-qspi".

Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
---
 Documentation/devicetree/bindings/mtd/fsl-quadspi.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
index 0333ec8..c34aa6f 100644
--- a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
@@ -5,7 +5,8 @@ Required properties:
 		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
 		 "fsl,ls1021a-qspi"
 		 or
-		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi"
+		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
+		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
   - reg : the first contains the register location and length,
           the second contains the memory mapping address and length
   - reg-names: Should contain the reg names "QuadSPI" and "QuadSPI-memory"
-- 
2.1.0.27.g96db324
