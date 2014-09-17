From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Wed, 17 Sep 2014 22:24:12 +0800
Subject: [PATCH v2 5/7] dt-bindings: add more chips in documentation for
 Mediatek SoC
In-Reply-To: <1410963854-17154-1-git-send-email-srv_yingjoe.chen@mediatek.com>
References: <1410963854-17154-1-git-send-email-srv_yingjoe.chen@mediatek.com>
Message-ID: <1410963854-17154-6-git-send-email-srv_yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Joe.C" <yingjoe.chen@mediatek.com>

Add MT8127 & MT8135 from Mediatek.

Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index fa25226..40a9745 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -1,10 +1,13 @@
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
 
 
 Supported boards:
-- 
1.8.1.1.dirty
