From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 11 Sep 2017 04:22:38 +0200
Subject: [PATCH 1/4] dt-bindings: arm: actions: Add S700 and CubieBoard7
In-Reply-To: <20170911022241.11603-1-afaerber@suse.de>
References: <20170911022241.11603-1-afaerber@suse.de>
Message-ID: <20170911022241.11603-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the Actions Semi S700 SoC and the Cubietech CubieBoard7.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/arm/actions.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/actions.txt b/Documentation/devicetree/bindings/arm/actions.txt
index ced764a8549e..544a8855fad5 100644
--- a/Documentation/devicetree/bindings/arm/actions.txt
+++ b/Documentation/devicetree/bindings/arm/actions.txt
@@ -25,6 +25,21 @@ Root node property compatible must contain, depending on board:
  - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker,guitar"
 
 
+S700 SoC
+========
+
+Required root node properties:
+
+- compatible :  must contain "actions,s700"
+
+
+Boards:
+
+Root node property compatible must contain, depending on board:
+
+ - Cubietech CubieBoard7: "cubietech,cubieboard7"
+
+
 S900 SoC
 ========
 
-- 
2.13.5
