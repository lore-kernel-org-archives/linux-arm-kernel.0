From: joel@jms.id.au (Joel Stanley)
Date: Mon,  9 May 2016 22:04:36 +0930
Subject: [PATCH 1/2] doc/devicetree: Add Aspeed watchdog timer bindings
In-Reply-To: <1462797277-14969-1-git-send-email-joel@jms.id.au>
References: <1462797277-14969-1-git-send-email-joel@jms.id.au>
Message-ID: <1462797277-14969-2-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
new file mode 100644
index 000000000000..58184b161e0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
@@ -0,0 +1,14 @@
+Aspeed Watchdog Timer
+
+Required properties:
+ - compatible: must be "aspeed,wdt"
+ - reg: physical base address of the controller and length of memory mapped
+   region
+
+Example:
+
+	wdt1: wdt at 1e785000 {
+		compatible = "aspeed,wdt";
+		reg = <0x1e785000 0x1c>;
+		interrupts = <27>;
+	};
-- 
2.8.1
