From: jitao.shi@mediatek.com (Jitao Shi)
Date: Wed, 17 Feb 2016 14:50:38 +0800
Subject: [PATCH 1/2] dt-bindings: Add LG lp120up1 panel bindings
Message-ID: <1455691839-2410-1-git-send-email-jitao.shi@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for lp120up1 panel

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 .../bindings/display/panel/lg,lp120up1.txt         |    7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,lp120up1.txt

diff --git a/Documentation/devicetree/bindings/display/panel/lg,lp120up1.txt b/Documentation/devicetree/bindings/display/panel/lg,lp120up1.txt
new file mode 100644
index 0000000..ff0b6c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lg,lp120up1.txt
@@ -0,0 +1,7 @@
+LG 12.0" (1920x1280 pixels) TFT LCD panel
+
+Required properties:
+- compatible: should be "lg,lp120up1"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
1.7.9.5
