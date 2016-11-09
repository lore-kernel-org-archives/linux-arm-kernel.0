From: harninder.rai@nxp.com (Harninder Rai)
Date: Wed, 9 Nov 2016 23:40:53 +0530
Subject: [PATCH 3/3] dt-bindings: clockgen: Add compatible string for LS1012A
Message-ID: <1478715053-12790-1-git-send-email-harninder.rai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Harninder Rai <harninder.rai@nxp.com>
Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
---
 Documentation/devicetree/bindings/clock/qoriq-clock.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index df9cb5a..aa3526f 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -31,6 +31,7 @@ Required properties:
 	* "fsl,t4240-clockgen"
 	* "fsl,b4420-clockgen"
 	* "fsl,b4860-clockgen"
+	* "fsl,ls1012a-clockgen"
 	* "fsl,ls1021a-clockgen"
 	* "fsl,ls1043a-clockgen"
 	* "fsl,ls1046a-clockgen"
-- 
2.7.4
