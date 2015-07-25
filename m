From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Fri, 24 Jul 2015 17:21:20 -0700
Subject: [RFCv2 1/3] docs: dts: Added documentation for Xilinx Zynq Reset
 Controller bindings.
In-Reply-To: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>
References: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <1437783682-13632-2-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 Documentation/devicetree/bindings/reset/zynq-reset-pl.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/zynq-reset-pl.txt

diff --git a/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt b/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
new file mode 100644
index 0000000..ac4499e
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
@@ -0,0 +1,13 @@
+Xilinx Zynq PL Reset Manager
+
+Required properties:
+- compatible: "xlnx,zynq-reset-pl"
+- syscon <&slcr>;
+- #reset-cells: 1
+
+Example:
+	rstc: rstc at 240 {
+		#reset-cells = <1>;
+		compatible = "xlnx,zynq-reset-pl";
+		syscon = <&slcr>;
+	};
-- 
2.4.3
