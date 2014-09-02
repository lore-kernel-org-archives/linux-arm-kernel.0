From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue,  2 Sep 2014 14:19:07 -0700
Subject: [PATCH v2 2/9] Documentation: devicetree: Add binding for Synopsys
 DDR controller
In-Reply-To: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1409692754-13437-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 .../devicetree/bindings/memory-controllers/synopsys.txt       | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/synopsys.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
new file mode 100644
index 000000000000..f9c6454146b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
@@ -0,0 +1,11 @@
+Binding for Synopsys IntelliDDR Multi Protocol Memory Controller
+
+Required properties:
+ - compatible: Should be 'xlnx,zynq-ddrc-a05'
+ - reg: Base address and size of the controllers memory area
+
+Example:
+	memory-controller at f8006000 {
+		compatible = "xlnx,zynq-ddrc-a05";
+		reg = <0xf8006000 0x1000>;
+	};
-- 
2.1.0.1.g27b9230
