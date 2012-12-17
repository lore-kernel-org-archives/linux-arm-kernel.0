From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 17 Dec 2012 08:18:01 +0200
Subject: [PATCH 1/4] ARM: dt: Add doc for ARM Snoop Control Unit(SCU)
Message-ID: <1355725087-11363-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add scu.txt under arm for ARM Snoop Control Unit(SCU)

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 Documentation/devicetree/bindings/arm/scu.txt |   15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/scu.txt

diff --git a/Documentation/devicetree/bindings/arm/scu.txt b/Documentation/devicetree/bindings/arm/scu.txt
new file mode 100644
index 0000000..96264cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/scu.txt
@@ -0,0 +1,15 @@
+* ARM Snoop Control Unit(SCU)
+
+ARM cores often have a configurable SCU to the memory system through
+the AXI interfaces.
+
+Required properties:
+
+- compatible : "arm,cortex-a9-scu"
+- reg : Specifies base physical address and size of the SCU registers.
+
+Example:
+	scu {
+		compatible = "arm,cortex-a9-scu";
+		reg = <0x50040000 0x58>;
+	};
-- 
1.7.9.5
