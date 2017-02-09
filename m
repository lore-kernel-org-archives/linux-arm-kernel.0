From: harninder.rai@nxp.com (Harninder Rai)
Date: Thu, 9 Feb 2017 16:33:49 +0530
Subject: [PATCH 1/3] dt-bindings: clockgen: Add compatible string for LS1088A
Message-ID: <1486638229-7917-1-git-send-email-harninder.rai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Harninder Rai <harninder.rai@nxp.com>
---
 Documentation/devicetree/bindings/clock/qoriq-clock.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index aa3526f..6ed469c 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -35,6 +35,7 @@ Required properties:
 	* "fsl,ls1021a-clockgen"
 	* "fsl,ls1043a-clockgen"
 	* "fsl,ls1046a-clockgen"
+	* "fsl,ls1088a-clockgen"
 	* "fsl,ls2080a-clockgen"
 	Chassis-version clock strings include:
 	* "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
-- 
2.7.4
