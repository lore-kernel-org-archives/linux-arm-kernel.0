From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 24 Sep 2014 22:49:00 +0800
Subject: [PATCH v2 6/7] devicetree: bindings: Document supported Allwinner
 sunxi SoCs
In-Reply-To: <1411570141-29960-1-git-send-email-wens@csie.org>
References: <1411570141-29960-1-git-send-email-wens@csie.org>
Message-ID: <1411570141-29960-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a list of supported Allwinner SoC bindings.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/arm/sunxi.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunxi.txt

diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
new file mode 100644
index 0000000..d7d1039
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -0,0 +1,12 @@
+Allwinner sunXi Platforms Device Tree Bindings
+
+Each device tree must specify which Allwinner SoC it uses,
+using one of the following compatible stirngs:
+
+  allwinner,sun4i-a10
+  allwinner,sun5i-a10s
+  allwinner,sun5i-a13
+  allwinner,sun6i-a31
+  allwinner,sun7i-a20
+  allwinner,sun8i-a23
+  allwinner,sun9i-a80
-- 
2.1.0
