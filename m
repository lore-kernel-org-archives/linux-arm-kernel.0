From: carlo@caione.org (Carlo Caione)
Date: Sun, 19 Jun 2016 14:39:00 +0200
Subject: [PATCH 2/6] documentation: Add secure monitor bindings documentation
In-Reply-To: <1466339944-602-1-git-send-email-carlo@caione.org>
References: <1466339944-602-1-git-send-email-carlo@caione.org>
Message-ID: <1466339944-602-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add the binding documentation for the Amlogic secure monitor driver.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 .../devicetree/bindings/firmware/meson/meson_sm.txt       | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/meson/meson_sm.txt

diff --git a/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt b/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
new file mode 100644
index 0000000..c248cd4
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
@@ -0,0 +1,15 @@
+* Amlogic Secure Monitor
+
+In the Amlogic SoCs the Secure Monitor code is used to provide access to the
+NVMEM, enable JTAG, set USB boot, etc...
+
+Required properties for the secure monitor node:
+- compatible: Should be "amlogic,meson-gxbb-sm"
+
+Example:
+
+	firmware {
+		sm: secure-monitor {
+			compatible = "amlogic,meson-gxbb-sm";
+		};
+	};
-- 
2.7.4
