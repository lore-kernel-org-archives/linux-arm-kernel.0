From: Anson.Huang@nxp.com (Anson Huang)
Date: Mon, 8 Jan 2018 10:04:50 +0800
Subject: [PATCH V3 1/2] ARM: dts: imx6ul: add 696MHz operating point
Message-ID: <1515377091-10422-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 696MHz operating point according to datasheet
(Rev. 0, 12/2015).

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
changes since v2:
	add reviewed-by.
 arch/arm/boot/dts/imx6ul.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index d5181f8..963e169 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -68,12 +68,14 @@
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
