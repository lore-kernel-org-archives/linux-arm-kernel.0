From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Wed, 1 Aug 2018 15:34:56 +0530
Subject: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx zynqmp
 FPGA manager
Message-ID: <20180801100457.25614-1-nava.manne@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New bindings document for zynqmp fpga manager.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
 .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
new file mode 100644
index 000000000000..0eac747747f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
@@ -0,0 +1,9 @@
+Xilinx Zynqmp FPGA Manager
+
+Required properties:
+- compatible:		should contain "xlnx,zynqmp-pcap-fpga"
+
+Example:
+	pcap: pcap at 00 {
+		compatible = "xlnx,zynqmp-pcap-fpga";
+	};
-- 
2.18.0
