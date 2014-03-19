From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 19 Mar 2014 15:49:24 +0100
Subject: [PATCH 3/3] ARM: dts: i.MX53: Add reset line to VPU device node
In-Reply-To: <1395240564-25940-1-git-send-email-l.stach@pengutronix.de>
References: <1395240564-25940-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1395240564-25940-3-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index a6f361b08439..4ecf773b52f5 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -666,6 +666,7 @@
 				clocks = <&clks IMX5_CLK_VPU_GATE>,
 				         <&clks IMX5_CLK_VPU_GATE>;
 				clock-names = "per", "ahb";
+				resets = <&src 1>;
 				iram = <&ocram>;
 			};
 		};
-- 
1.9.0
