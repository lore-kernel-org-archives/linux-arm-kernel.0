From: b32955@freescale.com (Huang Shijie)
Date: Tue, 7 May 2013 15:39:18 +0800
Subject: [PATCH 1/3] ARM: dts: imx6q: remove the unused pins for gpmi-nand
Message-ID: <1367912360-3283-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpmi does not use the MX6Q_PAD_NANDF_CS2__NAND_CE2_B and
MX6Q_PAD_NANDF_CS3__NAND_CE3_B.

Just remove them.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6q.dtsi |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 21e6758..ed11bcf 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -168,8 +168,6 @@
 							MX6Q_PAD_NANDF_RB0__NAND_READY_B 0xb000
 							MX6Q_PAD_NANDF_CS0__NAND_CE0_B   0xb0b1
 							MX6Q_PAD_NANDF_CS1__NAND_CE1_B   0xb0b1
-							MX6Q_PAD_NANDF_CS2__NAND_CE2_B   0xb0b1
-							MX6Q_PAD_NANDF_CS3__NAND_CE3_B   0xb0b1
 							MX6Q_PAD_SD4_CMD__NAND_RE_B      0xb0b1
 							MX6Q_PAD_SD4_CLK__NAND_WE_B      0xb0b1
 							MX6Q_PAD_NANDF_D0__NAND_DATA00   0xb0b1
-- 
1.7.1
