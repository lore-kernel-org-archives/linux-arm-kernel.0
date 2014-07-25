From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 25 Jul 2014 10:15:18 +0200
Subject: [PATCH] ARM: zynq: DT: Clarify Xilinx Zynq platform
Message-ID: <7153c8eded88751e7637f08f2bfe9cb6a65036e7.1406275971.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ep107 was emulation platform and compatible string
have been changed long time ago.

"ARM: zynq: dts: split up device tree"
(sha1: e06f1a9ed7ebff170ba05d2606d079fb36c6a52d)

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 Documentation/devicetree/bindings/arm/xilinx.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index 6f1ed830b4f7..1f7995357888 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -1,7 +1,7 @@
-Xilinx Zynq EP107 Emulation Platform board
+Xilinx Zynq Platforms Device Tree Bindings

-This board is an emulation platform for the Zynq product which is
-based on an ARM Cortex A9 processor.
+Boards with Zynq-7000 SOC based on an ARM Cortex A9 processor
+shall have the following properties.

 Required root node properties:
-    - compatible = "xlnx,zynq-ep107";
+    - compatible = "xlnx,zynq-7000";
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/26699e9e/attachment.sig>
