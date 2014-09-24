From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 24 Sep 2014 15:18:49 +0200
Subject: [PATCH] ARM: zynq: DT: Add missing address for L2 pl310
Message-ID: <178aa08adfcc161fbf902d6127202089e37e03dd.1411564723.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By in sync with others node and add also baseaddr
to the node name.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 64caeb47bc0c..5020de584521 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -136,7 +136,7 @@
 			      <0xF8F00100 0x100>;
 		};

-		L2: cache-controller {
+		L2: cache-controller at f8f02000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xF8F02000 0x1000>;
 			arm,data-latency = <3 2 2>;
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140924/4f623522/attachment.sig>
