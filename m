From: nm@ti.com (Nishanth Menon)
Date: Fri, 22 Aug 2014 09:01:00 -0500
Subject: [PATCH 1/3] pinctrl: bindings: Add OMAP pinctrl binding
In-Reply-To: <1408716062-26055-1-git-send-email-nm@ti.com>
References: <1408716062-26055-1-git-send-email-nm@ti.com>
Message-ID: <1408716062-26055-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic skeleton of OMAP pinctrl bindings. This is compatible with
pinctrl,single bindings and is meant purely as a reference point.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../bindings/pinctrl/ti,omap-pinctrl.txt           |    9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt
new file mode 100644
index 0000000..156d964
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt
@@ -0,0 +1,9 @@
+OMAP Pinctrl definitions
+
+Required properties:
+- compatible : Should be one of:
+  "ti,omap3-padconf" - OMAP3 compatible pinctrl
+  "ti,omap4-padconf" - OMAP4 compatible pinctrl
+  "ti,omap5-padconf" - OMAP5 compatible pinctrl
+
+See Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt for further details.
-- 
1.7.9.5
