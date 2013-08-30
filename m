From: b32955@freescale.com (Huang Shijie)
Date: Fri, 30 Aug 2013 10:07:28 +0800
Subject: [PATCH v3 7/8] ARM: dts: vf610: change the PAD values for Quadspi
In-Reply-To: <1377828449-18912-1-git-send-email-b32955@freescale.com>
References: <1377828449-18912-1-git-send-email-b32955@freescale.com>
Message-ID: <1377828449-18912-8-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current pad values do not works in the 66M DDR quad read mode.

This patch adjusts this pad values, and tested in the 66M DDR quad read
mode with S25FL128S.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/vf610.dtsi |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 67d929c..c622562 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -285,18 +285,18 @@
 				qspi0 {
 					pinctrl_qspi0_1: qspi0grp_1 {
 						fsl,pins = <
-						VF610_PAD_PTD0__QSPI0_A_QSCK	0x307b
-						VF610_PAD_PTD1__QSPI0_A_CS0	0x307f
-						VF610_PAD_PTD2__QSPI0_A_DATA3	0x3073
-						VF610_PAD_PTD3__QSPI0_A_DATA2	0x3073
-						VF610_PAD_PTD4__QSPI0_A_DATA1	0x3073
-						VF610_PAD_PTD5__QSPI0_A_DATA0	0x307b
-						VF610_PAD_PTD7__QSPI0_B_QSCK	0x307b
-						VF610_PAD_PTD8__QSPI0_B_CS0	0x307f
-						VF610_PAD_PTD9__QSPI0_B_DATA3	0x3073
-						VF610_PAD_PTD10__QSPI0_B_DATA2	0x3073
-						VF610_PAD_PTD11__QSPI0_B_DATA1	0x3073
-						VF610_PAD_PTD12__QSPI0_B_DATA0	0x307b
+						VF610_PAD_PTD0__QSPI0_A_QSCK	0x31c3
+						VF610_PAD_PTD1__QSPI0_A_CS0	0x31ff
+						VF610_PAD_PTD2__QSPI0_A_DATA3	0x31c3
+						VF610_PAD_PTD3__QSPI0_A_DATA2	0x31c3
+						VF610_PAD_PTD4__QSPI0_A_DATA1	0x31c3
+						VF610_PAD_PTD5__QSPI0_A_DATA0	0x31c3
+						VF610_PAD_PTD7__QSPI0_B_QSCK	0x31c3
+						VF610_PAD_PTD8__QSPI0_B_CS0	0x31ff
+						VF610_PAD_PTD9__QSPI0_B_DATA3	0x31c3
+						VF610_PAD_PTD10__QSPI0_B_DATA2	0x31c3
+						VF610_PAD_PTD11__QSPI0_B_DATA1	0x31c3
+						VF610_PAD_PTD12__QSPI0_B_DATA0	0x31c3
 						>;
 					};
 				};
-- 
1.7.1
