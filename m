From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 30 Jul 2012 11:23:16 -0300
Subject: [PATCH] ARM: dts: imx27-3ds.dts: Fix serial console node
Message-ID: <1343658196-24243-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix serial console node and allow the board to boot again.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx27-3ds.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-3ds.dts b/arch/arm/boot/dts/imx27-3ds.dts
index d3f8296..0a8978a 100644
--- a/arch/arm/boot/dts/imx27-3ds.dts
+++ b/arch/arm/boot/dts/imx27-3ds.dts
@@ -27,7 +27,7 @@
 				status = "okay";
 			};
 
-			uart at 1000a000 {
+			uart1: serial at 1000a000 {
 				fsl,uart-has-rtscts;
 				status = "okay";
 			};
-- 
1.7.1
