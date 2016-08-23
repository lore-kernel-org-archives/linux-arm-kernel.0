From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 Aug 2016 13:39:04 +0200
Subject: [PATCH v3 2/4] dt-bindings: arm: Add Sierra Wireless modules bindings
In-Reply-To: <1471952346-30676-1-git-send-email-narmstrong@baylibre.com>
References: <1471952346-30676-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471952346-30676-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/swir.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/swir.txt

diff --git a/Documentation/devicetree/bindings/arm/swir.txt b/Documentation/devicetree/bindings/arm/swir.txt
new file mode 100644
index 0000000..042be73
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/swir.txt
@@ -0,0 +1,12 @@
+Sierra Wireless Modules device tree bindings
+--------------------------------------------
+
+Supported Modules :
+ - WP8548 : Includes MDM9615 and PM8018 in a module
+
+Sierra Wireless modules shall have the following properties :
+  Required root node property
+   - compatible: "swir,wp8548" for the WP8548 CF3 Module
+
+Board compatible values:
+  - "swir,mangoh-green-wp8548" for the mangOH green board with the WP8548 module
-- 
1.9.1
