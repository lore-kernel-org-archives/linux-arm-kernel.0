From: lars.persson@axis.com (Lars Persson)
Date: Wed, 10 Feb 2016 13:41:52 +0100
Subject: [PATCH 3/8] arm: add device-tree SoC bindings for Axis Artpec-6
In-Reply-To: <cover.1455107681.git.larper@axis.com>
References: <cover.1455107681.git.larper@axis.com>
Message-ID: <06f7e5ffdef7ba79b5702f063512010329c40cba.1455107681.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lars Persson <larper@axis.com>
---
 Documentation/devicetree/bindings/arm/axis.txt | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/axis.txt

diff --git a/Documentation/devicetree/bindings/arm/axis.txt b/Documentation/devicetree/bindings/arm/axis.txt
new file mode 100644
index 0000000..4c98701
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/axis.txt
@@ -0,0 +1,8 @@
+Axis Communications AB
+ARTPEC series SoC Device Tree Bindings
+
+
+ARTPEC-6 ARM SoC
+
+Required root node properties:
+    - compatible = "axis,artpec6-dev-board", "axis,artpec6";
-- 
2.1.4
