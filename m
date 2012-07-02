From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  2 Jul 2012 16:50:27 -0300
Subject: [PATCH 2/2] ARM: imx6q-sabresd.dts: Add watchdog support
In-Reply-To: <1341258627-3469-1-git-send-email-festevam@gmail.com>
References: <1341258627-3469-1-git-send-email-festevam@gmail.com>
Message-ID: <1341258627-3469-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add watchdog support.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabresd.dts |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
index 07509a1..f3002d2 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dts
+++ b/arch/arm/boot/dts/imx6q-sabresd.dts
@@ -29,6 +29,10 @@
 					status = "okay";
 				};
 			};
+
+			wdog at 020bc000 { /* WDOG1 */
+				status = "okay";
+			};
 		};
 
 		aips-bus at 02100000 { /* AIPS2 */
-- 
1.7.1
