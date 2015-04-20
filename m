From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 20 Apr 2015 13:50:22 -0500
Subject: [PATCHv2 1/4] ARM: socfpga: add cpu1-start-addr for Arria 10
In-Reply-To: <1429555825-23560-1-git-send-email-dinguyen@opensource.altera.com>
References: <1429555825-23560-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1429555825-23560-2-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 8a05c47..69d616a 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -284,6 +284,7 @@
 		sysmgr: sysmgr at ffd06000 {
 			compatible = "altr,sys-mgr", "syscon";
 			reg = <0xffd06000 0x300>;
+			cpu1-start-addr = <0xffd06230>;
 		};
 
 		/* Local timer */
-- 
2.2.1
