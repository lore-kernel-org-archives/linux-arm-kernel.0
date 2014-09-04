From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Fri, 5 Sep 2014 07:51:00 +0800
Subject: [PATCH 5/5] dt-bindings: add more chips in documentation for Mediatek
 SoC
In-Reply-To: <1409874660-8710-1-git-send-email-srv_yingjoe.chen@mediatek.com>
References: <1409874660-8710-1-git-send-email-srv_yingjoe.chen@mediatek.com>
Message-ID: <1409874660-8710-6-git-send-email-srv_yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Joe.C" <yingjoe.chen@mediatek.com>

Add MT8127 & MT8135 from Mediatek.

Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index d6ac71f..451d48d 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -1,8 +1,11 @@
-Mediatek MT6589 Platforms Device Tree Bindings
+Mediatek Platforms Device Tree Bindings
 
-Boards with a SoC of the Mediatek MT6589 shall have the following property:
+Boards with a SoC of the Mediatek shall have the following property:
 
 Required root node property:
 
-compatible: must contain "mediatek,mt6589"
+compatible: Must contain one of
+   "mediatek,mt6589"
+   "mediatek,mt8127"
+   "mediatek,mt8135"
 
-- 
1.8.1.1.dirty
