From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 14 Feb 2017 04:34:37 +0100
Subject: [PATCH 2/4] Documentation: devicetree: arm: Add Realtek RTD1295
 bindings
In-Reply-To: <20170214033440.18667-1-afaerber@suse.de>
References: <20170214033440.18667-1-afaerber@suse.de>
Message-ID: <20170214033440.18667-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/arm/realtek.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/realtek.txt

diff --git a/Documentation/devicetree/bindings/arm/realtek.txt b/Documentation/devicetree/bindings/arm/realtek.txt
new file mode 100644
index 0000000..cfbee58
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/realtek.txt
@@ -0,0 +1,15 @@
+Realtek platforms device tree bindings
+--------------------------------------
+
+
+RTD1295 SoC
+===========
+
+Required root node properties:
+
+ - compatible :  "realtek,rtd1295"
+
+
+Board compatible strings:
+
+ - Zidoo X9S: "zidoo,x9s"
-- 
2.10.2
