From: baruch@tkos.co.il (Baruch Siach)
Date: Mon,  5 Sep 2016 18:05:13 +0300
Subject: [PATCH] dt-bindings: mvebu-odmi: fix example typo
Message-ID: <0743fef6fe390bc4ae7cabd15c4836bbed98f7cf.1473087913.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the example compatible string match its definition.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../bindings/interrupt-controller/marvell,odmi-controller.txt           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt
index 8af0a8e613ab..3f6442c7f867 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt
@@ -31,7 +31,7 @@ Required properties:
 Example:
 
 	odmi: odmi at 300000 {
-		compatible = "marvell,ap806-odm-controller",
+		compatible = "marvell,ap806-odmi-controller",
 			     "marvell,odmi-controller";
 		interrupt-controller;
 		msi-controller;
-- 
2.9.3
