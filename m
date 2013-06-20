From: b32955@freescale.com (Huang Shijie)
Date: Thu, 20 Jun 2013 14:00:08 +0800
Subject: [PATCH 1/3] ARM: dts: imx6dl: add a new pinctrl for ecspi1
Message-ID: <1371708010-22710-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new pinctrl is used in the imx6dl-sabresd board.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 2b3ecd6..b8f6fab 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -56,6 +56,13 @@
 							MX6DL_PAD_EIM_D16__ECSPI1_SCLK 0x100b1
 						>;
 					};
+					pinctrl_ecspi1_2: ecspi1cr-1 {
+						fsl,pins = <
+							MX6DL_PAD_KEY_COL1__ECSPI1_MISO 0x100b1
+							MX6DL_PAD_KEY_ROW0__ECSPI1_MOSI 0x100b1
+							MX6DL_PAD_KEY_COL0__ECSPI1_SCLK 0x100b1
+						>;
+					};
 				};
 
 				enet {
-- 
1.7.1
