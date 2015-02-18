From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 18 Feb 2015 19:25:54 +0100
Subject: [PATCH 1/6] ASoC: max98088: Document DT bindings
In-Reply-To: <1424283959-16289-1-git-send-email-afaerber@suse.de>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
Message-ID: <1424283959-16289-2-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/sound/max98088.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98088.txt

diff --git a/Documentation/devicetree/bindings/sound/max98088.txt b/Documentation/devicetree/bindings/sound/max98088.txt
new file mode 100644
index 000000000000..6f8fe85040ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/max98088.txt
@@ -0,0 +1,16 @@
+MAX98088 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "maxim,max98088" or "maxim,max98089".
+
+- reg : The I2C address of the device.
+
+Example:
+
+max98089: codec at 10 {
+	compatible = "maxim,max98089";
+	reg = <0x10>;
+};
-- 
2.1.4
