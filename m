From: Eugen.Hristev@microchip.com (Eugen.Hristev at microchip.com)
Date: Wed, 21 Nov 2018 08:48:00 +0000
Subject: [PATCH 2/3] dt-bindings: drm/panel: simple: add support for PDA
 91-00156-A0
In-Reply-To: <1542789804-4584-1-git-send-email-eugen.hristev@microchip.com>
References: <1542789804-4584-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <1542789804-4584-3-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cristian Birsan <cristian.birsan@microchip.com>

PDA 91-00156-A0 5.0 is a 5.0" WVGA TFT LCD panel.
This panel with backlight is found in PDA 5" LCD screen (TM5000 series or
AC320005-5).
Adding Device Tree bindings for this panel.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 .../devicetree/bindings/display/panel/pda,91-00156-a0.txt          | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt

diff --git a/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt b/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
new file mode 100644
index 0000000..52f0da9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
@@ -0,0 +1,7 @@
+PDA 91-00156-A0 5.0" WVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "pda,91-00156-a0"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.7.4
