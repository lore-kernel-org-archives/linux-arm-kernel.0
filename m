From: alex.gonzalez@digi.com (Alex Gonzalez)
Date: Mon, 5 Nov 2018 11:48:04 +0100
Subject: [PATCH] ARM: dts: imx6ul: ccimx6ulsom: Fix indentation on iomuxc nodes
Message-ID: <1541414884-19619-1-git-send-email-alex.gonzalez@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch corrects indentation problems in the gpmigrp and i2c1grp nodes.

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
index ef26b2389c8f..c41ecee68ad9 100644
--- a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
@@ -198,15 +198,15 @@
 			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0xb0b1
 			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0xb0b1
 			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0xb0b1
-			>;
-		};
+		>;
+	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL 0x4001b8b0
 			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA 0x4001b8b0
-			>;
-		};
+		>;
+	};
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
