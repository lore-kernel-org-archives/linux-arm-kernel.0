From: chen.zhong@mediatek.com (Chen Zhong)
Date: Wed, 25 Oct 2017 21:16:00 +0800
Subject: [PATCH v6 2/6] dt-bindings: input: Add common keyboard document
 bindings
In-Reply-To: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
References: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
Message-ID: <1508937364-30054-3-git-send-email-chen.zhong@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree binding documentation for common
keyboard.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
---
 Documentation/devicetree/bindings/input/keys.txt |    8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/keys.txt

diff --git a/Documentation/devicetree/bindings/input/keys.txt b/Documentation/devicetree/bindings/input/keys.txt
new file mode 100644
index 0000000..a0ea7eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/keys.txt
@@ -0,0 +1,8 @@
+General Keys Properties:
+
+Optional properties for Keys:
+- power-off-time-sec: Duration in seconds which the key should be kept
+ 	pressed for device to power off automatically. Device with key pressed
+ 	shutdown feature can specify this property.
+- linux,keycodes: Specifies the numeric keycode values to be used for
+	reporting key presses.
\ No newline at end of file
-- 
1.7.9.5
