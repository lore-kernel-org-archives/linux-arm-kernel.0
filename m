From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Thu, 21 May 2015 20:14:00 -0500
Subject: [PATCH] ARM: socfpga: dts: add the a9-scu node for arria10
Message-ID: <1432257240-3509-1-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Add a dts node for the A9 SCU on the Arria10 platform.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 8a05c47..4cf0733 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -281,6 +281,11 @@
 			reg = <0xffd05000 0x100>;
 		};
 
+		scu: snoop-control-unit at ffffc000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0xffffc000 0x100>;
+		};
+
 		sysmgr: sysmgr at ffd06000 {
 			compatible = "altr,sys-mgr", "syscon";
 			reg = <0xffd06000 0x300>;
-- 
1.9.1.315.g3f09db0
