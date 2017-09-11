From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 11 Sep 2017 02:58:04 +0200
Subject: [PATCH 1/2] dt-bindings: arm: actions: Add CubieBoard6
In-Reply-To: <20170911005805.10116-1-afaerber@suse.de>
References: <20170911005805.10116-1-afaerber@suse.de>
Message-ID: <20170911005805.10116-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define a compatible string for Cubietech CubieBoard6.

Cc: support at cubietech.com
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/arm/actions.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/actions.txt b/Documentation/devicetree/bindings/arm/actions.txt
index 3bc7ea575564..ced764a8549e 100644
--- a/Documentation/devicetree/bindings/arm/actions.txt
+++ b/Documentation/devicetree/bindings/arm/actions.txt
@@ -21,6 +21,7 @@ Boards:
 
 Root node property compatible must contain, depending on board:
 
+ - Cubietech CubieBoard6: "cubietech,cubieboard6"
  - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker,guitar"
 
 
-- 
2.13.5
