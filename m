From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 13 Jan 2015 13:28:56 +0100
Subject: [PATCH v5 2/2] ARM: mediatek: dts: Add bindings for watchdog
In-Reply-To: <1421152136-5007-1-git-send-email-matthias.bgg@gmail.com>
References: <1421152136-5007-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1421152136-5007-3-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
new file mode 100644
index 0000000..af9eb5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -0,0 +1,13 @@
+Mediatek SoCs Watchdog timer
+
+Required properties:
+
+- compatible : should be "mediatek,mt6589-wdt"
+- reg : Specifies base physical address and size of the registers.
+
+Example:
+
+wdt: watchdog at 010000000 {
+	compatible = "mediatek,mt6589-wdt";
+	reg = <0x10000000 0x18>;
+};
-- 
1.9.1
