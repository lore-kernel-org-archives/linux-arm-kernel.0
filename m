From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 12 May 2015 17:49:09 -0500
Subject: [PATCH 1/2] ARM: socfpga: dts: add the a9-scu node
Message-ID: <1431470950-29492-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Add the dts node for the A9 SCU.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index d9176e6..5cefa82 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -655,6 +655,11 @@
 			status = "disabled";
 		};
 
+		scu: snoop-control-unit at fffec000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0xfffec000 0x100>;
+		};
+
 		spi1: spi at fff01000 {
 			compatible = "snps,dw-apb-ssi";
 			#address-cells = <1>;
-- 
2.2.1
