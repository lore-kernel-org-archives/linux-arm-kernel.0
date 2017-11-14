From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 14 Nov 2017 19:01:13 +0100
Subject: [PATCH 2/3] dt-bindings: arm: actions: Add Sparky
In-Reply-To: <20171114180114.26408-1-afaerber@suse.de>
References: <20171114180114.26408-1-afaerber@suse.de>
Message-ID: <20171114180114.26408-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define a binding for Allo.com Sparky SBC.

Cc: Ioan B. <ioan@allo.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/arm/actions.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/actions.txt b/Documentation/devicetree/bindings/arm/actions.txt
index 544a8855fad5..d54f33c4e0da 100644
--- a/Documentation/devicetree/bindings/arm/actions.txt
+++ b/Documentation/devicetree/bindings/arm/actions.txt
@@ -21,6 +21,7 @@ Boards:
 
 Root node property compatible must contain, depending on board:
 
+ - Allo.com Sparky: "allo,sparky"
  - Cubietech CubieBoard6: "cubietech,cubieboard6"
  - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker,guitar"
 
-- 
2.13.6
