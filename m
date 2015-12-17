From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Thu, 17 Dec 2015 16:16:52 -0500
Subject: [PATCH 1/2] ARM: dts: TS-4800: drop uart rts/cts pin reservations
Message-ID: <1450387013-3532-1-git-send-email-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These pins are actually not routed for UARTs, they should not be
reserved.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 arch/arm/boot/dts/imx51-ts4800.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
index f1317f7..64ac55c 100644
--- a/arch/arm/boot/dts/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/imx51-ts4800.dts
@@ -157,8 +157,6 @@
 		fsl,pins = <
 			MX51_PAD_UART1_RXD__UART1_RXD		0x1c5
 			MX51_PAD_UART1_TXD__UART1_TXD		0x1c5
-			MX51_PAD_UART1_RTS__UART1_RTS		0x1c5
-			MX51_PAD_UART1_CTS__UART1_CTS		0x1c5
 		>;
 	};
 
@@ -173,8 +171,6 @@
 		fsl,pins = <
 			MX51_PAD_EIM_D25__UART3_RXD		0x1c5
 			MX51_PAD_EIM_D26__UART3_TXD		0x1c5
-			MX51_PAD_EIM_D27__UART3_RTS		0x1c5
-			MX51_PAD_EIM_D24__UART3_CTS		0x1c5
 		>;
 	};
 };
-- 
2.5.0
