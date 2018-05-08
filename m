From: Bhaskar.Upadhaya@nxp.com (Bhaskar Upadhaya)
Date: Tue, 8 May 2018 11:59:59 +0530
Subject: [PATCH 2/2] dt-bindings: Add compatible string for FRWY-LS1012A
In-Reply-To: <1525760999-6187-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1525760999-6187-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <1525760999-6187-2-git-send-email-Bhaskar.Upadhaya@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index cdb9dd7..0517440 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -147,6 +147,10 @@ LS1012A ARMv8 based RDB Board
 Required root node properties:
     - compatible = "fsl,ls1012a-rdb", "fsl,ls1012a";
 
+LS1012A ARMv8 based FRWY Board
+Required root node properties:
+    - compatible = "fsl,frwy-ls1012a", "fsl,ls1012a";
+
 LS1012A ARMv8 based FRDM Board
 Required root node properties:
     - compatible = "fsl,ls1012a-frdm", "fsl,ls1012a";
-- 
1.9.1
