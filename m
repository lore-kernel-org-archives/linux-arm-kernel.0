From: david@lechnology.com (David Lechner)
Date: Fri, 13 Jan 2017 13:03:40 -0600
Subject: [PATCH v4 2/4] dt-bindings: Add LEGO MINDSTORMS EV3 compatible
 specification
In-Reply-To: <1484334222-14223-1-git-send-email-david@lechnology.com>
References: <1484334222-14223-1-git-send-email-david@lechnology.com>
Message-ID: <1484334222-14223-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the board level device tree specification for LEGO MINDSTORMS EV3

Signed-off-by: David Lechner <david@lechnology.com>
---
 Documentation/devicetree/bindings/arm/davinci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/davinci.txt b/Documentation/devicetree/bindings/arm/davinci.txt
index f0841ce..715622c 100644
--- a/Documentation/devicetree/bindings/arm/davinci.txt
+++ b/Documentation/devicetree/bindings/arm/davinci.txt
@@ -13,6 +13,10 @@ EnBW AM1808 based CMC board
 Required root node properties:
     - compatible = "enbw,cmc", "ti,da850;
 
+LEGO MINDSTORMS EV3 (AM1808 based)
+Required root node properties:
+    - compatible = "lego,ev3", "ti,da850";
+
 Generic DaVinci Boards
 ----------------------
 
-- 
2.7.4
