From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  2 Jul 2012 16:50:26 -0300
Subject: [PATCH 1/2] ARM: imx6q-sabrelite.dts: Add watchdog support
Message-ID: <1341258627-3469-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add watchdog support.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index e0ec929..99581a0 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -42,6 +42,9 @@
 				};
 			};
 
+			wdog at 020bc000 { /* WDOG1 */
+				status = "okay";
+			};
 		};
 
 		aips-bus at 02100000 { /* AIPS2 */
-- 
1.7.1
