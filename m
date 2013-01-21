From: marex@denx.de (Marek Vasut)
Date: Mon, 21 Jan 2013 21:05:22 +0100
Subject: [PATCH 2/2] ARM: mxs: Add OF props for MX23 LRADC
In-Reply-To: <1358798722-25102-1-git-send-email-marex@denx.de>
References: <1358798722-25102-1-git-send-email-marex@denx.de>
Message-ID: <1358798722-25102-2-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add interrupt mapping and compatible string for MX23 LRADC.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 65415c5..56afcf4 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -391,7 +391,9 @@
 			};
 
 			lradc at 80050000 {
+				compatible = "fsl,imx23-lradc";
 				reg = <0x80050000 0x2000>;
+				interrupts = <36 37 38 39 40 41 42 43 44>;
 				status = "disabled";
 			};
 
-- 
1.7.10.4
