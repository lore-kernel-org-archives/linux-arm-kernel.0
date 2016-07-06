From: stillcompiling@gmail.com (Joshua Clayton)
Date: Wed,  6 Jul 2016 15:59:17 -0700
Subject: [REPOST v3 2/2] drm/panel: simple: Add Documentation for Sharp
 LQ101K1LY04
In-Reply-To: <1467845957-29036-1-git-send-email-stillcompiling@gmail.com>
References: <1467845957-29036-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <1467845957-29036-2-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document basic simple-panel support for Sharp LQ101K1LY04

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/panel/sharp,lq101k1ly04.txt        | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq101k1ly04.txt

diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq101k1ly04.txt b/Documentation/devicetree/bindings/display/panel/sharp,lq101k1ly04.txt
new file mode 100644
index 0000000..4aff25b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sharp,lq101k1ly04.txt
@@ -0,0 +1,7 @@
+Sharp Display Corp. LQ101K1LY04 10.07" WXGA TFT LCD panel
+
+Required properties:
+- compatible: should be "sharp,lq101k1ly04"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.7.4
