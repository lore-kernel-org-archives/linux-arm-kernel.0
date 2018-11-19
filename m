From: sugaya.taichi@socionext.com (Sugaya Taichi)
Date: Mon, 19 Nov 2018 10:01:07 +0900
Subject: [PATCH 02/14] dt-bindings: soc: milbeaut: Add Milbeaut trampoline
 description
In-Reply-To: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
Message-ID: <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings document for Milbeaut trampoline.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../devicetree/bindings/soc/socionext/socionext,m10v.txt     | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt

diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
new file mode 100644
index 0000000..f5d906c
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
@@ -0,0 +1,12 @@
+Socionext M10V SMP trampoline driver binding
+
+This is a driver to wait for sub-cores while boot process.
+
+- compatible: should be "socionext,smp-trampoline"
+- reg: should be <0x4C000100 0x100>
+
+EXAMPLE
+	trampoline: trampoline at 0x4C000100 {
+		compatible = "socionext,smp-trampoline";
+		reg = <0x4C000100 0x100>;
+	};
-- 
1.9.1
