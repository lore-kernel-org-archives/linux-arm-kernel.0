From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 26 May 2016 09:51:51 +0200
Subject: [RFC PATCH 2/3] dt-bindings: watchdog: Add Meson GXBB Watchdog
 bindings
In-Reply-To: <1464249112-13658-1-git-send-email-narmstrong@baylibre.com>
References: <1464249112-13658-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1464249112-13658-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/watchdog/meson-gxbb-wdt.txt         | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
new file mode 100644
index 0000000..d06c0a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
@@ -0,0 +1,13 @@
+Meson GXBB SoCs Watchdog timer
+
+Required properties:
+
+- compatible : should be "amlogic,meson-gxbb-wdt"
+- reg : Specifies base physical address and size of the registers.
+
+Example:
+
+wdt: watchdog at 98d0 {
+	compatible = "amlogic,meson-gxbb-wdt";
+	reg = <0 0x98d0 0x0 0x10>;
+};
-- 
2.7.0
