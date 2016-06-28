From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 28 Jun 2016 12:51:12 +0800
Subject: [PATCH v1 1/5] dt-bindings: Add support for LG LP079QX1-SP0V
 1536x2048 panel
In-Reply-To: <1467089288-18355-1-git-send-email-ykk@rock-chips.com>
References: <1467089288-18355-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1467089472-18584-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LG LP079QX1-SP0V is an 7.9" QXGA TFT with LED Backlight unit and
32 pins eDP interface. This module supports 1536x2048 mode.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 .../devicetree/bindings/display/panel/lg,lp079qx1-sp0v.txt         | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,lp079qx1-sp0v.txt

diff --git a/Documentation/devicetree/bindings/display/panel/lg,lp079qx1-sp0v.txt b/Documentation/devicetree/bindings/display/panel/lg,lp079qx1-sp0v.txt
new file mode 100644
index 0000000..b9877ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lg,lp079qx1-sp0v.txt
@@ -0,0 +1,7 @@
+LG LP079QX1-SP0V 7.9" (1536x2048 pixels) TFT LCD panel
+
+Required properties:
+- compatible: should be "lg,lp079qx1-sp0v"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
1.9.1
