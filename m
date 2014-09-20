From: carlo@caione.org (Carlo Caione)
Date: Sat, 20 Sep 2014 19:06:49 +0200
Subject: [PATCH v4 1/4] ARM: docs: add documentation binding for meson watchdog
In-Reply-To: <1411232812-11594-1-git-send-email-carlo@caione.org>
References: <1411232812-11594-1-git-send-email-carlo@caione.org>
Message-ID: <1411232812-11594-2-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Carlo Caione <carlo@caione.org>
---
 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
new file mode 100644
index 0000000..9200fc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
@@ -0,0 +1,13 @@
+Meson SoCs Watchdog timer
+
+Required properties:
+
+- compatible : should be "amlogic,meson6-wdt"
+- reg : Specifies base physical address and size of the registers.
+
+Example:
+
+wdt: watchdog at c1109900 {
+	compatible = "amlogic,meson6-wdt";
+	reg = <0xc1109900 0x8>;
+};
-- 
1.9.1
