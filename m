From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 20 Feb 2016 15:37:56 +0100
Subject: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
Message-ID: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a binding for the Wolfson WM9713 audio codec.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 Documentation/devicetree/bindings/sound/wm9713.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/wm9713.txt

diff --git a/Documentation/devicetree/bindings/sound/wm9713.txt b/Documentation/devicetree/bindings/sound/wm9713.txt
new file mode 100644
index 000000000000..761001bc3201
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm9713.txt
@@ -0,0 +1,14 @@
+WM9713 audio CODEC
+
+This devices supports I2C.
+
+Required properties:
+  - compatible :
+	"wlf,wm9713"
+
+Example:
+	wm9713: wm9713 at 0 {
+		compatible = "wlf,wm9713";
+		#sound-dai-cells = <1>;
+		status = "okay";
+	};
-- 
2.1.4
