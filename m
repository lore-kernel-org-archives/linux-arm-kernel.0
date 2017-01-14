From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Sat, 14 Jan 2017 15:05:28 +0800
Subject: [PATCH v1 1/3] dt: bindings: add documentation for zx2967 family
 reset controller
Message-ID: <1484377530-30635-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dt-binding documentation for zx2967 family
reset controller.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 .../devicetree/bindings/reset/zte,zx2967-reset.txt   | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt b/Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
new file mode 100644
index 0000000..22d590e
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
@@ -0,0 +1,20 @@
+ZTE zx2967 SoCs Reset Controller
+=======================================
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+- compatible: should be one of the following.
+	* zte,zx296718-reset
+- reg: physical base address of the controller and length of memory mapped
+	region.
+- #reset-cells: must be 1.
+
+example:
+
+	toprst: reset at 1461060 {
+		compatible = "zte,zx296718-reset";
+		reg = <0x01461060 0x8>;
+		#reset-cells = <1>;
+	};
-- 
2.7.4
