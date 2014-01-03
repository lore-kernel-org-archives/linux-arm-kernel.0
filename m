From: Frank.Li@freescale.com (Frank Li)
Date: Sat, 4 Jan 2014 06:53:52 +0800
Subject: [PATCH v2 2/2] ARM: dts: imx: enable dma for spi
In-Reply-To: <1388789632-12238-1-git-send-email-Frank.Li@freescale.com>
References: <1388789632-12238-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1388789632-12238-2-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable dma support for espci controller

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

No change from v1 

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 858ecd7..6b29f56 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -184,6 +184,8 @@
 					interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks 112>, <&clks 112>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -195,6 +197,8 @@
 					interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks 113>, <&clks 113>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -206,6 +210,8 @@
 					interrupts = <0 33 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks 114>, <&clks 114>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -217,6 +223,8 @@
 					interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks 115>, <&clks 115>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 9 7 1>, <&sdma 10 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
-- 
1.7.8
