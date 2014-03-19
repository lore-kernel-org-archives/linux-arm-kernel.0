From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 19 Mar 2014 15:49:23 +0100
Subject: [PATCH 2/3] ARM: dts: i.MX53: Enable CODA7541 VPU
In-Reply-To: <1395240564-25940-1-git-send-email-l.stach@pengutronix.de>
References: <1395240564-25940-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1395240564-25940-2-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

This IP module is always present and has no external connections.
There is no reason to disable it in the device tree.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 80615dfa2177..a6f361b08439 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -667,7 +667,6 @@
 				         <&clks IMX5_CLK_VPU_GATE>;
 				clock-names = "per", "ahb";
 				iram = <&ocram>;
-				status = "disabled";
 			};
 		};
 
-- 
1.9.0
