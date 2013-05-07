From: b32955@freescale.com (Huang Shijie)
Date: Tue, 7 May 2013 15:39:19 +0800
Subject: [PATCH 2/3] ARM: dts: imx6dl: add pinctrl for gpmi-nand
In-Reply-To: <1367912360-3283-1-git-send-email-b32955@freescale.com>
References: <1367912360-3283-1-git-send-email-b32955@freescale.com>
Message-ID: <1367912360-3283-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add the pinctrl item for gpmi-nand.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 5bcdf3a..24544ed 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -78,6 +78,30 @@
 					};
 				};
 
+				gpmi-nand {
+					pinctrl_gpmi_nand_1: gpmi-nand-1 {
+						fsl,pins = <
+							MX6DL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
+							MX6DL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
+							MX6DL_PAD_NANDF_WP_B__NAND_WP_B   0xb0b1
+							MX6DL_PAD_NANDF_RB0__NAND_READY_B 0xb000
+							MX6DL_PAD_NANDF_CS0__NAND_CE0_B   0xb0b1
+							MX6DL_PAD_NANDF_CS1__NAND_CE1_B   0xb0b1
+							MX6DL_PAD_SD4_CMD__NAND_RE_B      0xb0b1
+							MX6DL_PAD_SD4_CLK__NAND_WE_B      0xb0b1
+							MX6DL_PAD_NANDF_D0__NAND_DATA00   0xb0b1
+							MX6DL_PAD_NANDF_D1__NAND_DATA01   0xb0b1
+							MX6DL_PAD_NANDF_D2__NAND_DATA02   0xb0b1
+							MX6DL_PAD_NANDF_D3__NAND_DATA03   0xb0b1
+							MX6DL_PAD_NANDF_D4__NAND_DATA04   0xb0b1
+							MX6DL_PAD_NANDF_D5__NAND_DATA05   0xb0b1
+							MX6DL_PAD_NANDF_D6__NAND_DATA06   0xb0b1
+							MX6DL_PAD_NANDF_D7__NAND_DATA07   0xb0b1
+							MX6DL_PAD_SD4_DAT0__NAND_DQS      0x00b1
+						>;
+					};
+				};
+
 				uart1 {
 					pinctrl_uart1_1: uart1grp-1 {
 						fsl,pins = <
-- 
1.7.1
