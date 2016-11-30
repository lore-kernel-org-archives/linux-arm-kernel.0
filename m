From: ping.bai@nxp.com (Bai Ping)
Date: Wed, 30 Nov 2016 11:04:57 +0800
Subject: [PATCH 1/2] ARM: dts: imx: Add 696MHz setpoint for imx6ul
Message-ID: <1480475098-2037-1-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 696MHz setpoint support for i.MX6UL.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 612827d..3ade04e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -60,12 +60,14 @@
 			clock-latency = <61036>; /* two CLK32 periods */
 			operating-points = <
 				/* kHz	uV */
+				696000	1275000
 				528000	1175000
 				396000	1025000
 				198000	950000
 			>;
 			fsl,soc-operating-points = <
 				/* KHz	uV */
+				696000	1275000
 				528000	1175000
 				396000	1175000
 				198000	1175000
-- 
1.9.1
