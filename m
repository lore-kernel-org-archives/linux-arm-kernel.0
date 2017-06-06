From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:11 +0200
Subject: [PATCH v4 13/28] dt-bindings: arm: Document Actions Semi S900
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-14-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Actions Semi S900 is a quad-core ARM Cortex-A53 SoC.
The Bubblegum-96 is a 96Boards Consumer Edition compliant board (4/96).

Cc: 96boards at ucrobotics.com
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3 -> v4: unchanged
 
 v1 -> v2:
 * Adopted "actions" vendor prefix
 * Extended text
 
 Documentation/devicetree/bindings/arm/actions.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/actions.txt b/Documentation/devicetree/bindings/arm/actions.txt
index 1d3782e41b00..3bc7ea575564 100644
--- a/Documentation/devicetree/bindings/arm/actions.txt
+++ b/Documentation/devicetree/bindings/arm/actions.txt
@@ -22,3 +22,18 @@ Boards:
 Root node property compatible must contain, depending on board:
 
  - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker,guitar"
+
+
+S900 SoC
+========
+
+Required root node properties:
+
+- compatible :  must contain "actions,s900"
+
+
+Boards:
+
+Root node property compatible must contain, depending on board:
+
+ - uCRobotics Bubblegum-96: "ucrobotics,bubblegum-96"
-- 
2.12.3
