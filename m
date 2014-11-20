From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 20 Nov 2014 22:01:38 +0800
Subject: [PATCH] ARM: dts: atlas6: add resets property for VPP nodes
Message-ID: <1416492098-5090-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Renwei Wu <Renwei.Wu@csr.com>

this patch adds missed resets property for CSR SiRFatlasVI Video Post
Processor(VPP) node.

Signed-off-by: Renwei Wu <renwei.wu@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index bb22842..9dce23f 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -131,6 +131,7 @@
 				reg = <0x90020000 0x10000>;
 				interrupts = <31>;
 				clocks = <&clks 35>;
+				resets = <&rstc 6>;
 			};
 		};
 
-- 
2.1.1
