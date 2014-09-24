From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 24 Sep 2014 16:01:32 +0200
Subject: [PATCH 1/2] ARM: zynq: DT: Add missing reference for ADC
Message-ID: <fced9e56dc4ef8df9ead34f6444c010cc31c7a61.1411567289.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing reference for ADC node.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 772381fe07bb..fc90f47f9c03 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -64,7 +64,7 @@
 		interrupt-parent = <&intc>;
 		ranges;

-		adc at f8007100 {
+		adc: adc at f8007100 {
 			compatible = "xlnx,zynq-xadc-1.00.a";
 			reg = <0xf8007100 0x20>;
 			interrupts = <0 7 4>;
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140924/ea25650a/attachment.sig>
