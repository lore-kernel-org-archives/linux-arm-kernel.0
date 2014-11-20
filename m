From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 20 Nov 2014 22:15:52 +0800
Subject: [PATCH] ARM: dts: atlas6: add resets property for SPI nodes
Message-ID: <1416492952-5496-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

this patch adds missed resets property for CSR SiRFatlasVI SPI nodes.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 9dce23f..10f10b4 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -313,6 +313,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&clks 19>;
+				resets = <&rstc 26>;
 				status = "disabled";
 			};
 
@@ -328,6 +329,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&clks 20>;
+				resets = <&rstc 27>;
 				status = "disabled";
 			};
 
-- 
2.1.1
